const Message = require('../models/Message');
const mongoose = require('mongoose');
const Profile = require('../models/Profile');
const Love = require('../models/Love');


const filterLinks = (message) => {
    const urlPattern = /https?:\/\/[^\s]+/g;
    if (message.match(urlPattern)) {
      return true; 
    }
    return false; 
};
const checkPhoneNumber = (message) => {
    const phoneRegex = /\b(\+?(\d{1,4}))?(\s|\-|\.)?(\(?\d{1,3}\)?)(\s|\-|\.)?(\d{1,4})(\s|\-|\.)?(\d{1,4})(\s|\-|\.)?(\d{1,4})\b/g;
    return phoneRegex.test(message); 
};

exports.checkMatch = async (req, res) => {
    try {
        const senderId = req.params.userId;
        const { receiverId } = req.body;

        if (!receiverId) {
            return res.status(400).json({ message: 'Thiếu thông tin người nhận' });
        }

        const sender = await Profile.findOne({ accountId: senderId });
        const receiver = await Profile.findOne({ accountId: receiverId });

        if (!sender || !receiver) {
            return res.status(400).json({ message: 'Không tìm thấy profile người gửi hoặc người nhận' });
        }
        const isMatch = sender.whoyoulike.some(profile => profile.accountId === receiverId) &&
                        receiver.whoyoulike.some(profile => profile.accountId === senderId);
        const isMatch2 = sender.whoyousuperlike.some(profile => profile.accountId === receiverId) &&
        receiver.whoyousuperlike.some(profile => profile.accountId === senderId);

        if (!isMatch && !isMatch2) {
            return res.status(400).json({ message: 'Không thể gửi tin nhắn, không phải là match' });
        }
        res.status(200).json({ message: 'Có thể gửi tin nhắn' });

    } catch (error) {
        res.status(500).json({ message: 'Lỗi khi kiểm tra match', error });
    }
};
exports.send = async (req, res) => {
    try {
        const { receiverId, content } = req.body;
        const senderId = req.params.userId;
        if (!receiverId || !content) {
            return res.status(400).json({ message: 'Thiếu thông tin người nhận hoặc nội dung tin nhắn' });
        }
        const sender = await Profile.findOne({accountId:senderId});
        const receiver = await Profile.findOne({accountId:receiverId});        
        
        if (filterLinks(content) || checkPhoneNumber(content)) {
            return res.status(400).json({ message: 'Nội dung tin nhắn không không lệ' });
        }
       
        let imageUrls = [];
    if (req.files && req.files.length > 0) {
      // Mỗi file được lưu tại thư mục uploads/images
      imageUrls = req.files.map(file => `uploads/images/${file.filename}`);
    }
        
        const message = await Message.create({
            sender:{
                accountId: senderId,
                name: sender.name,
                image: sender.images[0]
            },
            receiver:{
                accountId: receiverId,
                name: receiver.name,
                image: receiver.images[0]
            },
            content,
            imageUrl: imageUrls

        });
        // Emit sự kiện Socket.IO
        req.app.get('io').to(receiver).emit('newMessage', message);

        return res.status(200).json({ message: 'Tin nhắn đã gửi', data: message });
    } catch (error) {
        res.status(500).json({ message: 'Lỗi khi gửi tin nhắn', error });
    }
};

exports.get = async (req, res) => {
    try {
        const userId = req.params.userId; 
        const { clientId } = req.body; 

        if (!userId || !clientId) {
            return res.status(400).json({ message: 'Thiếu thông tin người dùng hoặc clientId' });
        }
        const love = await Love.findOne({
            $or: [
                { senderId: userId ,receiverId: clientId },
                { receiverId: userId,senderId: clientId}
            ]
        });
        let status="friend";
        if (love!=null) {
            status = love.status;
        } 
        
        // Tìm tin nhắn giữa userId và clientId
        const messages = await Message.find({
            $or: [
                { 'sender.accountId': clientId, 'receiver.accountId':userId },
                { 'sender.accountId': userId, 'receiver.accountId':clientId }
            ]
        }).sort({ createdAt: 1 });  
        if(status==='pending'){
            return res.status(200).json({status: status,req: love, data: messages });
        }else{
            return res.status(200).json({status: status, data: messages });
        }
    } catch (error) {
        console.error(error);  // Log chi tiết lỗi
        res.status(500).json({ message: 'Lỗi khi lấy tin nhắn', error: error.message });
    }
};

exports.getAll = async (req, res) => {
    try {
        const userId = req.params.userId;
        const profile = await Profile.findOne({ accountId: userId });
        if (!profile) {
            return res.status(400).json({ message: 'Không tìm thấy profile' });
        }
        if(profile.isLove==true) {
            const love = await Love.findOne({
                $or: [
                    { 'sender.accountId': userId },
                    { 'sender.accountId': userId }
                ]
            });            
            const chat = await Message.findOne({
                $or: [
                    { 'sender.accountId': love.sender.accountId, 'receiver.accountId': love.receiver.accountId },
                    { 'sender.accountId': love.receiver.accountId, 'receiver.accountId': love.sender.accountId }
                ]
            }).sort({ createdAt: -1 });
            return res.status(200).json({ message: 'Danh sách tin nhắn', data: chat });
                
        }else{
            const chats = await Message.aggregate([
                {
                    $match: {
                        $or: [{ 'sender.accountId': userId},{'receiver.accountId':userId }]
                    }
                },
                {
                    $group: {
                        _id: {
                            $cond: [
                                { $eq: ['$sender.accountId',userId] },
                                '$receiver.accountId',
                                '$sender.accountId',
                            ]
                        },
                        lastMessage: { $last: '$$ROOT' }
                    }
                }
            ]);
            chats.sort((a, b) => new Date(b.lastMessage.createdAt) - new Date(a.lastMessage.createdAt));

            return res.status(200).json({ message: 'Danh sách cuộc trò chuyện', data: chats });
        }
    } catch (error) {
        res.status(500).json({ message: 'Lỗi khi lấy cuộc trò chuyện', error });
    }
};
exports.update = async (req, res) => {
    
    try {
        const messId = req.params.messId;
        const message = await Message.findById(messId);
        message.isread=true;
        await message.save();
        return res.status(200).json({ message: 'Đã đọc tin nhắn', data: message });
    }
    catch (error) {
        res.status(500).json({ message: 'Lỗi khi đọc tin nhắn', error });
    }
        
};