const mongoose = require('mongoose');
const Love = require('../models/Love');
const Profile = require('../models/Profile');

exports.send = async (req, res) => {
    try{
        const { receiverId } = req.body;
        const senderId = req.params.senderId;
        if (!receiverId) {
            return res.status(400).json({ message: 'Thiếu thông tin người nhận' });
        }
        const sender = await Profile.findOne({accountId:senderId});
        const receiver = await Profile.findOne({accountId:receiverId});
        if (!sender || !receiver) {
            return res.status(400).json({ message: 'Không tìm thấy profile người gửi hoặc người nhận' });
        }
        const haveSent = await Love.findOne({senderId: senderId, receiverId: receiverId});
        if (haveSent) {
            return res.status(401).json({ message: 'Đã gửi yêu thích' });
        }
        const love = new Love({
            sender: {accountId: sender.accountId, name: sender.name, images: sender.images},
            receiver: {accountId: receiver.accountId, name: receiver.name, images: receiver.images},
        });
        await love.save();
        res.status(200).json({message: 'Yêu thích đã được gửi', love: love});
    }catch(err){
        res.status(500).json({message: 'Lỗi khi gửi yêu thích', error: err});
    }
};
exports.getLoveInfor = async (req, res) => {
    try {
        const { userId } = req.params; // Lấy userId từ params

        // Kiểm tra xem có mối quan hệ nào với trạng thái "success" không
        const love = await Love.findOne({
            $and: [
                { $or: [{ "sender.accountId": userId }, { "receiver.accountId": userId }] },
                { status: 'success' }
            ]
        });

        if (love) {
            let candidateId = love.sender.accountId === userId ? love.receiver.accountId : love.sender.accountId;
            return res.status(200).json({ love: love, message: 'success', candidateId: candidateId });
        }

        // Lấy danh sách Love mà user đã gửi
        const sendLove = await Love.find({ "sender.accountId": userId });

        // Lấy danh sách Love mà user đã nhận
        const receiveLove = await Love.find({ "receiver.accountId": userId });

        return res.status(200).json({ sendLove: sendLove, receiveLove: receiveLove, message: 'pending' });
    } catch (err) {
        res.status(500).json({ message: 'Lỗi khi lấy thông tin yêu thích', error: err.message });
    }
};

exports.accept = async (req, res) => {
    try {
        const { receiverId, senderId } = req.body;

        // Tìm love hiện tại giữa senderId và receiverId
        const love = await Love.findOne({
            $and: [{ 'sender.accountId': senderId }, { 'receiver.accountId': receiverId }]
        });

        if (!love) {
            return res.status(404).json({ message: 'Yêu cầu không tồn tại' });
        }

        // Cập nhật trạng thái thành "success"
        love.status = 'success';
        await love.save();
        const profileSender = await Profile.findOne({accountId:senderId});
        const profileReceiver = await Profile.findOne({accountId: receiverId});
        profileSender.isLove=true;
        profileReceiver.isLove=true;
        await profileSender.save();
        await profileReceiver.save();

        // Xóa tất cả love khác có senderId hoặc receiverId trong đó
        await Love.deleteMany({
            $or: [
                { 'sender.accountId': senderId },
                { 'receiver.accountId': senderId },
                { 'sender.accountId': receiverId },
                { 'receiver.accountId': receiverId }
            ],
            _id: { $ne: love._id } // Tránh xóa chính love vừa chấp nhận
        });

        res.status(200).json({ message: 'success', love: love , profileSender: profileSender, profileReceiver: profileReceiver});
    } catch (err) {
        res.status(500).json({ message: 'Lỗi khi chấp nhận yêu thích', error: err });
    }
};


exports.reject = async (req, res) => {
    try{
        const loveId = req.params.loveId;

        const love = await Love.findById(loveId);
        if (!love) {
            return res.status(404).json({ message: 'Yêu cau không tồn tại' });
        }
        await love.remove();
        res.status(200).json({message: 'Yêu thích đã được từ chối'});
    }catch(err){
        res.status(500).json({message: 'Lỗi khi chấp nhận yêu thích', error: err});
    }
};
exports.delete = async (req, res) => {
    try {
        const userId = req.params.userId; // Lấy chính xác userId
        const clientId = req.body.clientId;

        if (!userId || !clientId) {
            return res.status(400).json({ message: 'Thiếu thông tin để hủy yêu thích' });
        }

        // Tìm kiếm bản ghi yêu thích giữa 2 người
        const love = await Love.findOne({
            $or: [
                { 'sender.accountId': userId, 'receiver.accountId': clientId },
                { 'sender.accountId': clientId, 'receiver.accountId': userId }
            ]
        });

        if (!love) {
            return res.status(400).json({ message: 'Không tìm thấy yêu thích' });
        }
        if(love.status=='success'){
            const profileSender = await Profile.findOne({accountId: userId});
        const profileReceiver = await Profile.findOne({accountId: clientId});
        profileSender.isLove=false;
        profileReceiver.isLove=false;
        await profileSender.save();
        await profileReceiver.save();
        await Love.deleteOne({ _id: love._id });
        res.status(200).json({ message: 'Yêu thích đã được hủy', profileSender: profileSender, profileReceiver: profileReceiver, type: 'success' });
        }
        // Xóa bản ghi yêu thích
        await Love.deleteOne({ _id: love._id });
                

        res.status(200).json({ message: 'Yêu thích đã được hủy', type: 'pending' });
    } catch (err) {
        console.error("Lỗi khi hủy yêu thích:", err);
        res.status(500).json({ message: 'Lỗi khi hủy yêu thích', error: err.message });
    }
};

exports.attend = async (req, res) => {
    try{
        const userId = req.params.userId;
        const love=await Love.findOne({$or:[{senderId:userId},{receiverId:userId}]});
        if(!love || love.status!=='success'){
            return res.status(400).json({message: 'Không tìm thấy yêu thích'});
        }
        if(love.attendence.user1Id==userId){
            return res.status(400).json({message: 'haved'});
        }else if(love.attendence.user1Id==''){
            love.attendence.user1Id=userId;
        }else if(love.attendence.user2Id==''&&userId!=love.attendence.user1Id){
            love.attendence.user1Id='';
            love.attendence.days+=1;
        }
        await love.save();
        return res.status(200).json({message: 'tham gia thành công'});
    }catch(err){
        res.status(500).json({message: 'Lỗi khi tham gia', error: err});
    }
};