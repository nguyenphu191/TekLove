const Profile= require('../models/Profile');
const Account = require('../models/Account');
const mongoose = require('mongoose');
const Love = require('../models/Love');
const upload = require('../middleware/upload');
const fs = require('fs');
const path = require('path');

exports.createProfile = async (req, res) => {
    const { accountId } = req.params;
    const {name, images,gender,genderlike,birthday,findfor,priorityDistance,university,habits,interests, sexuality, showSexInProfile, showGenderInProfile} = req.body;
    try{
        let profileCompletion=68;
        const verified = false;
        
        if(university==""){
            profileCompletion-=8;
        }
        if(habits.length==0){
            profileCompletion-=8;
        }if(interests.length==0){
            profileCompletion-=8;
        } if(images.length==0){
            profileCompletion-=8;
        }
        const existProfile = await Profile.findOne({accountId: accountId});
        if(existProfile){
            return res.status(400).json({message: 'Profile đã tồn tại'});
        }
        const profile = new Profile({
            accountId,
            name,
            images,
            gender,
            genderlike,
            birthday,
            findfor,
            sexuality,
            priorityDistance,
            university,
            habits,
            interests,
            showSexInProfile,
            showGenderInProfile,
            location: { latitude: 0, longitude: 0 },
            profileCompletion,
            verified});
        await profile.save();
        return res.status(200).json({profile: profile});

    }catch(e){
        return res.status(400).json({error: e.message});
    }
};
exports.getProfile = async (req, res) => {
    const { accountId } = req.params;
    try{
        const profile = await Profile.findOne({accountId: accountId});
        if(!profile){
            return res.status(404).json({message: 'Profile not found'});
        }
        return res.status(200).json({profile: profile});
    }catch(e){
        return res.status(400).json({error: e.message});
    }
};
exports.getMatch = async (req, res) => {
    const { accountId } = req.params;
    try {
        const profile = await Profile.findOne({ accountId: accountId });
        if (!profile) {
            return res.status(404).json({ message: 'Không tìm thấy hồ sơ' });
        }

        // Chuyển danh sách thành Set để tìm kiếm nhanh hơn
        const whoLikeYouSet = new Set(profile.wholikeyou.map(p => p.accountId));
        const whoSuperLikeYouSet = new Set(profile.whosuperlikeyou.map(p => p.accountId));

        // Tìm những tài khoản có tương tác qua lại
        let match = new Set([
            ...profile.whoyoulike.filter(p => whoLikeYouSet.has(p.accountId)),
            ...profile.whoyousuperlike.filter(p => whoLikeYouSet.has(p.accountId)),
            ...profile.whoyoulike.filter(p => whoSuperLikeYouSet.has(p.accountId)),
            ...profile.whoyousuperlike.filter(p => whoSuperLikeYouSet.has(p.accountId))
        ]);

        return res.status(200).json({ match: Array.from(match) });
    } catch (e) {
        return res.status(400).json({ error: e.message });
    }
};


exports.updateProfile = async (req, res) => {
    
    const { accountId } = req.params;
    const updateData = req.body;
    console.log(updateData);
    console.log(accountId);
    try {
        const profile = await Profile.findOne({ accountId });
        if (!profile) {
            return res.status(404).json({ message: "Profile not found" });
        }

        // Chỉ cập nhật các trường được gửi từ client
        const updatedFields = {};
        const allowedFields = [
            "name", "avatar", "gender", "genderlike", "birthday",
            "findfor", "priorityDistance", "university", "habits", "sexuality",
            "interests", "weight", "height", "verified", " showGenderInProfile","showSexInProfile","slogen",
            "livingAddress", "job", "company", "moreInfor", "introduction","language"
        ];

        allowedFields.forEach((field) => {
            if (updateData[field] !== undefined) {
                updatedFields[field] = updateData[field];
            }
        });

        

        // Tính profileCompletion
        let profileCompletion = 100;
        if (!profile.height) profileCompletion -= 8;


        if (!profile.introduction) profileCompletion -= 8;
        if (!profile.voices || profile.voices.length === 0) profileCompletion -= 8;
        if (!profile.videos || profile.videos.length === 0) profileCompletion -= 8;
        if (!profile.university) profileCompletion -= 8;
        if (!profile.habits || profile.habits.length === 0) profileCompletion -= 8;
        if (!profile.interests || profile.interests.length === 0) profileCompletion -= 8;

        updatedFields.profileCompletion = profileCompletion;

        // Cập nhật profile trong MongoDB
        const updatedProfile = await Profile.findOneAndUpdate(
            { accountId },
            { $set: updatedFields },
            { new: true } // Trả về profile sau khi cập nhật
        );

        return res.status(200).json({
            message: "Profile updated successfully",
            profile: updatedProfile
        });
    } catch (error) {
        console.error("Error updating profile:", error);
        return res.status(500).json({ message: "Server error", error: error.message });
    }
};

exports.uploadProfileImages = async (req, res) => {
    const { accountId } = req.params;
  
    try {
      // Kiểm tra nếu không có file nào được upload
      if (!req.files || req.files.length === 0) {
        return res.status(400).json({ message: 'No image files uploaded' });
      }
  
      // Kiểm tra nếu không có accountId
      if (!accountId) {
        return res.status(400).json({ message: 'Missing accountId' });
      }
  
      // Kiểm tra profile của account
      const profile = await Profile.findOne({ accountId: accountId });
      if (!profile) {
        return res.status(404).json({ message: 'Profile not found' });
      }
  
      // Tạo danh sách URL ảnh từ các file được upload
      const uploadedImageUrls = req.files.map(file => `uploads/images/${file.filename}`);
  
      // Lưu danh sách URL vào trường images của profile
      profile.images.push(...uploadedImageUrls);
      await profile.save();
  
      console.log("✅ Upload thành công:", uploadedImageUrls);
      return res.status(200).json({ 
        message: 'Images uploaded successfully', 
        imageUrls: uploadedImageUrls,
        images: profile.images,
        profile: profile 
      });
  
    } catch (error) {
      console.error('❌ Upload Image Error:', error.message);
      return res.status(500).json({ 
        error: 'Failed to upload images', 
        details: error.message 
      });
    }
  };
  
  exports.deleteProfileImage = async (req, res) => {
    const { accountId } = req.params;
    const { imageUrl } = req.body;
    console.log(imageUrl);
    try {
        // Tìm profile dựa trên accountId
        const profile = await Profile.findOne({ accountId: accountId });
        if (!profile) {
            return res.status(404).json({ message: 'Profile not found' });
        }

        // Kiểm tra xem ảnh có tồn tại trong mảng images không
        const imageIndex = profile.images.indexOf(imageUrl);
        if (imageIndex === -1) {
            return res.status(404).json({ message: 'Image not found in profile' });
        }

        // Xóa ảnh khỏi mảng images
        profile.images.splice(imageIndex, 1);

        // Lưu lại profile sau khi xóa ảnh
        await profile.save();

        // Xóa file ảnh từ thư mục uploads (nếu cần)
        const imagePath = path.join(__dirname, '..', imageUrl);
        if (fs.existsSync(imagePath)) {
            fs.unlinkSync(imagePath);
        }

        return res.status(200).json({ message: 'Image deleted successfully', profile: profile });
    } catch (error) {
        console.error('Error deleting image:', error.message);
        return res.status(500).json({ error: 'Failed to delete image', details: error.message });
    }
};

exports.uploadProfileVideo = async (req, res) => {
    const { accountId } = req.params;

    try {
        const profile = await Profile.findOne({ accountId: accountId });
        if (!profile) {
            return res.status(404).json({ message: 'Profile not found' });
        }

        if (!req.file) {
            return res.status(400).json({ message: 'No video file uploaded' });
        }

        const videoUrl = `${req.protocol}://${req.get('host')}/uploads/videos/${req.file.filename}`;
        profile.videos.push(videoUrl); // Thêm URL video vào mảng

        await profile.save();

        return res.status(200).json({ 
            message: 'Video uploaded successfully',
            videoUrl: videoUrl,
            videos: profile.videos
        });
    } catch (error) {
        console.error('Upload Video Error:', error.message);
        return res.status(400).json({ error: error.message });
    }
};

exports.uploadProfileVoice = async (req, res) => {
    const { accountId } = req.params;

    try {
        const profile = await Profile.findOne({ accountId: accountId });
        if (!profile) {
            return res.status(404).json({ message: 'Profile not found' });
        }

        if (!req.file) {
            return res.status(400).json({ message: 'No voice file uploaded' });
        }

        const voiceUrl = `${req.protocol}://${req.get('host')}/uploads/voices/${req.file.filename}`;
        profile.voices.push(voiceUrl); // Thêm URL voice vào mảng

        await profile.save();

        return res.status(200).json({ 
            message: 'Voice uploaded successfully',
            voiceUrl: voiceUrl,
            voices: profile.voices
        });
    } catch (error) {
        console.error('Upload Voice Error:', error.message);
        return res.status(400).json({ error: error.message });
    }
};


function calculateDistance(lat1, lon1, lat2, lon2) {
    const R = 6371; // Bán kính Trái Đất (km)
    const dLat = (lat2 - lat1) * (Math.PI / 180);
    const dLon = (lon2 - lon1) * (Math.PI / 180);
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
              Math.cos(lat1 * (Math.PI / 180)) * Math.cos(lat2 * (Math.PI / 180)) *
              Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
}
exports.getAllProfile = async (req, res) => {
    try {
        const accId = req.params.accountId;
        const userProfile = await Profile.findOne({ accountId: accId });
        
        if (!userProfile) {
            return res.status(404).json({ message: 'User not found' });
        }

        // Bước 1: Kiểm tra tình trạng "love" và trả về hồ sơ của người có ny
        if (userProfile.isLove == true) {
            const love = await Love.findOne({
                $or: [
                    { senderId: accId },
                    { receiverId: accId }
                ]
            });

            let profile;
            if (love.sender.accountId == accId) {
                profile = await Profile.findOne({ accountId: love.receiver.accountId });
                return res.status(200).json({ profile: profile });
            } else if (love.receiver.accountId == accId) {
                profile = await Profile.findOne({ accountId: love.sender.accountId });
                return res.status(200).json({ profile: profile });
            }
        }

        //Lấy tất cả các hồ sơ và lọc theo các điều kiện
        let profiles = await Profile.find().where('accountId').ne(userProfile.accountId);

        // Lọc các hồ sơ đã bị người dùng bỏ qua (whoyouskip)
        profiles = profiles.filter(profile => !(userProfile.whoyouskip.some(profile1 => profile1.accountId === profile.accountId)));

         // Lọc các hồ sơ đã bị người dùng thích (whoyoulike)
         profiles = profiles.filter(profile => !(userProfile.whoyoulike.some(profile1 => profile1.accountId === profile.accountId)));

          // Lọc các hồ sơ đã bị người dùng siêu thích (whoyousuperlike)
        profiles = profiles.filter(profile => !(userProfile.whoyousuperlike.some(profile1 => profile1.accountId === profile.accountId)));

        // Chia hồ sơ thành 2 nhóm: isSpeed == true và isSpeed == false
        const speedProfiles = profiles.filter(profile => profile.isSpeed === true);  // Hồ sơ có isSpeed == true
        const regularProfiles = profiles.filter(profile => profile.isSpeed === false);  // Hồ sơ còn lại

        // Sắp xếp lại các hồ sơ:
        // - Đẩy các hồ sơ có isSpeed == true lên đầu
        // - Sau đó sắp xếp theo khoảng cách hoặc các yếu tố khác
        const sortedSpeedProfiles = speedProfiles.sort(profile => calculateDistance(
            userProfile.location.latitude, 
            userProfile.location.longitude,
            profile.location.latitude, 
            profile.location.longitude
        ));

        const sortedRegularProfiles = regularProfiles.sort(profile => calculateDistance(
            userProfile.location.latitude, 
            userProfile.location.longitude,
            profile.location.latitude, 
            profile.location.longitude
        ));

        // Kết hợp lại các hồ sơ đã được sắp xếp
        const sortedProfiles = [...sortedSpeedProfiles, ...sortedRegularProfiles];

        if (sortedProfiles.length === 0) {
            return res.status(404).json({ message: 'Không tìm thấy hồ sơ nào.' });
        }

        return res.status(200).json({ profiles: sortedProfiles });

    } catch (e) {
        return res.status(400).json({ error: e.message });
    }
};

exports.getDiscovery = async (req, res) => {
    try {
        const accId = req.params.accountId;
        const {key}= req.body;
        console.log(key);
        const userProfile = await Profile.findOne({ accountId: accId });
        
        if (!userProfile) {
            return res.status(404).json({ message: 'User not found' });
        }

        if (userProfile.isLove == true) {
            const love = await Love.findOne({
                $or: [
                    { senderId: accId },
                    { receiverId: accId }
                ]
            });

            let profile;
            if (love.sender.accountId == accId) {
                profile = await Profile.findOne({ accountId: love.receiver.accountId });
                return res.status(200).json({ profile: profile });
            } else if (love.receiver.accountId == accId) {
                profile = await Profile.findOne({ accountId: love.sender.accountId });
                return res.status(200).json({ profile: profile });
            }
        }

        //Lấy tất cả các hồ sơ và lọc theo các điều kiện
        let profiles = await Profile.find().where('accountId').ne(userProfile.accountId);

        // Lọc các hồ sơ đã bị người dùng bỏ qua (whoyouskip)
        profiles = profiles.filter(profile => !(userProfile.whoyouskip.some(profile1 => profile1.accountId === profile.accountId)));

         // Lọc các hồ sơ đã bị người dùng thích (whoyoulike)
         profiles = profiles.filter(profile => !(userProfile.whoyoulike.some(profile1 => profile1.accountId === profile.accountId)));

          // Lọc các hồ sơ đã bị người dùng siêu thích (whoyousuperlike)
        profiles = profiles.filter(profile => !(userProfile.whoyousuperlike.some(profile1 => profile1.accountId === profile.accountId)));
        // Lọc các hồ sơ theo từ khoá
        if( key=="Love"){
            profiles = profiles.filter(profile => profile.findfor === "Love" );
        }else if(key=="Friend"){
            profiles = profiles.filter(profile => profile.findfor === "Friends" );
        }else if(key=="NoBinding"){
            profiles = profiles.filter(profile => profile.findfor === "NoBinding" );
        }else if(key=="Dating"){
            profiles = profiles.filter(profile => profile.findfor === "Dating" );
        }else if(key=="Game"){
            profiles = profiles.filter(profile => profile.interests.includes("Chơi game") );
        }else if(key=="Music"){
            profiles = profiles.filter(profile => profile.interests.includes("Nghe nhạc") );
        }else if(key=="Movie"){
            profiles = profiles.filter(profile => profile.interests.includes("Xem phim") );
        }else if(key=="Cooking"){
            profiles = profiles.filter(profile => profile.interests.includes("Nấu ăn") );
        }else if(key=="Travel"){
            profiles = profiles.filter(profile => profile.interests.includes("Đi du lịch") );
        }else if(key=="Sport"){
            profiles = profiles.filter(profile => profile.interests.includes("Chơi thể thao") );
        }else if(key=="Verified"){
            profiles = profiles.filter(profile => profile.verified === true );
        }
        if (profiles.length === 0) {
            return res.status(200).json({ profiles: [] });
        }
        
        // Chia hồ sơ thành 2 nhóm: isSpeed == true và isSpeed == false
        const speedProfiles = profiles.filter(profile => profile.isSpeed === true);  // Hồ sơ có isSpeed == true
        const regularProfiles = profiles.filter(profile => profile.isSpeed === false);  // Hồ sơ còn lại

        // Sắp xếp lại các hồ sơ:
        // - Đẩy các hồ sơ có isSpeed == true lên đầu
        // - Sau đó sắp xếp theo khoảng cách hoặc các yếu tố khác
        const sortedSpeedProfiles = speedProfiles.sort(profile => calculateDistance(
            userProfile.location.latitude, 
            userProfile.location.longitude,
            profile.location.latitude, 
            profile.location.longitude
        ));

        const sortedRegularProfiles = regularProfiles.sort(profile => calculateDistance(
            userProfile.location.latitude, 
            userProfile.location.longitude,
            profile.location.latitude, 
            profile.location.longitude
        ));

        // Kết hợp lại các hồ sơ đã được sắp xếp
        const sortedProfiles = [...sortedSpeedProfiles, ...sortedRegularProfiles];

        if (sortedProfiles.length === 0) {
            return res.status(404).json({ message: 'Không tìm thấy hồ sơ nào.' });
        }
        
        console.log(sortedProfiles);
        return res.status(200).json({ profiles: sortedProfiles });

    } catch (e) {
        return res.status(400).json({ error: e.message });
    }
};
exports.proposeProfile = async (req, res) => {
    
    try{
        const{habit,interest,distance,userLocation} =req.body;
        const accId=req.params.accountId;
        const userProfile = await Profile.findOne({accountId: accId});
        const allProfiles = await Profile.find().filter(profile=>profile.accountId!==userProfile.accountId);
        if(allProfiles.length===0){
            return res.status(404).json({message: 'Không tìm thấy hồ sơ nào.'});
        }
        let profiles1;
        if(habit.length===0 && interest.length===0){
            profiles1 = allProfiles.filter(profile=>!(userProfile.whoyouskip.some(profile1=>profile1.accountId===profile.accountId) ));
        }else{
            profiles1 = await Profile.find(
                {
                    $or: [
                        { habits:{$elemMatch :{ $in: habit } }},
                        { interests:{$elemMatch: { $in: interest }} }
                    ],
                }
            );
        }
        profiles2 = profiles2.filter(profile=>!(userProfile.whoyouskip.some(profile1=>profile1.accountId===profile.accountId) ));
        const profiles2 = allProfiles.filter(profile => {
            if (profile.location && userLocation) {
                const profileDistance = calculateDistance(
                    userLocation.latitude,
                    userLocation.longitude,
                    profile.location.latitude,
                    profile.location.longitude
                );
                return profileDistance <= distance;
            }
            return false;
        });
        const profiles= profiles1.concat(profiles2);

        if (profiles.length === 0) {
            return res.status(404).json({ message: 'Không tìm thấy hồ sơ phù hợp.' });
        }
        return res.status(200).json({ profiles: profiles });
    }catch(error){
        return res.status(400).json({error: error.message});
    }
};

exports.filterWhoLikeYou = async (req, res) => {
    const{accountId} =req.params;
    const {distance, agemin,agemax, numimages, interests, isverified, superliked, addbiography} = req.body;
    try{
        let profiles 
        if(superliked==true){
            profiles = await Profile.find({accountId: accountId}).select('whosuperlikeyou');
        }else{
            profiles = await Profile.find({accountId: accountId}).select('wholikeyou whosuperlikeyou');
        }
        const filteredProfiles = profiles.filter(profile => {
            if (profile.location && userLocation) {
                const profileDistance = calculateDistance(
                    userLocation.latitude,
                    userLocation.longitude,
                    profile.location.latitude,
                    profile.location.longitude
                );
                return profileDistance <= distance;
            }
            return false;
        });
        if (filteredProfiles.length === 0) {
            return res.status(404).json({ message: 'Không tìm thấy hồ sơ phù hợp.' });
        }
        const filteredProfilesByAge = filteredProfiles.filter(profile => {
            const age = new Date().getFullYear() - new Date(profile.birthday).getFullYear();
            return age >= agemin && age <= agemax;
        });
        filteredProfiles=filteredProfilesByAge;
        if (filteredProfiles.length === 0) {
            return res.status(404).json({ message: 'Không tìm thấy hồ sơ phù hợp.' });
        }
        if(numimages !==0) {
            const filteredProfilesByImages = filteredProfiles.filter(profile => {
                return profile.images.length >= numimages;
            });
            filteredProfiles = filteredProfilesByImages;
            if (filteredProfiles.length === 0) {
                return res.status(404).json({ message: 'Không tìm thấy hồ sơ phù hợp.' });
            }
        }
        if(interests.length !==0) {
            const filteredProfilesByInterests = filteredProfiles.filter(profile => {
                return profile.interests.some(interest => interests.includes(interest));
            });
            filteredProfiles = filteredProfilesByInterests;
            if (filteredProfiles.length === 0) {
                return res.status(404).json({ message: 'Không tìm thấy hồ sơ phù hợp.' });
            }
        }
        if(isverified==true) {
            const filteredProfilesByVerified = filteredProfiles.filter(profile => {
                return profile.verified === true;
            });
            filteredProfiles = filteredProfilesByVerified;
            if (filteredProfiles.length === 0) {
                return res.status(404).json({ message: 'Không tìm thấy hồ sơ phù hợp.' });
            }
        }
        if(addbiography==true) {
            const filteredProfilesByBiography = filteredProfiles.filter(profile => {
                return profile.profileCompletion ==100;
            });
            filteredProfiles = filteredProfilesByBiography;
            if (filteredProfiles.length === 0) {
                return res.status(404).json({ message: 'Không tìm thấy hồ sơ phù hợp.' });
            }
        }
        return res.status(200).json({ profiles: filteredProfiles });
    }catch(error){
        return res.status(400).json({error: error.message});
    }
};
exports.likeProfile = async (req, res) => {  
    const { accountId } = req.params; 
    const { profileId } = req.body; 
    console.log(profileId);
    console.log(accountId);
    try {  
        const acc=await Account.findById(new mongoose.Types.ObjectId(accountId));
        if (!acc) {  
            return res.status(404).json({ message: 'Account not found' });  
        }
        if(acc.numberlike==0){
            return res.status(400).json({message: 'Out of likes'});
        }
        const profileToLike = await Profile.findOne({ accountId: profileId });  
        if (!profileToLike) {  
            return res.status(404).json({ message: 'Profile not found' });  
        }  

        const userProfile = await Profile.findOne({ accountId: accountId });  
        if (!userProfile) {  
            return res.status(404).json({ message: 'User not found' });  
        }  

        if (userProfile.whoyoulike.some(profile => profile.accountId === profileId)) {  
            return res.status(400).json({ message: 'Profile already liked' });  
        }  
        if(userProfile.whoyousuperlike.some(profile => profile.accountId === profileId)){
            return res.status(400).json({ message: 'Profile already super liked' });
        }
        if (userProfile.whoyouskip.some(profile => profile.accountId === profileId)) {  
            userProfile.whoyouskip = userProfile.whoyouskip.filter(profile => profile.accountId!== profileId);
            userProfile.markModified('whoyouskip');
        }

        userProfile.whoyoulike.push({
            accountId: profileToLike.accountId,
            name: profileToLike.name,
            birthday: profileToLike.birthday,
            image: profileToLike.images[0],
            priorityDistance: profileToLike.priorityDistance,
            verified: profileToLike.verified,
            findfor: profileToLike.findfor,

            location: profileToLike.location,
            interests: profileToLike.interests
        }); 
        profileToLike.wholikeyou.push({
            accountId: userProfile.accountId,
            name: userProfile.name,
            birthday: userProfile.birthday,
            image: userProfile.images[0],
            priorityDistance: userProfile.priorityDistance,
            verified: userProfile.verified,
            findfor: userProfile.findfor,
            location: userProfile.location,
            interests: userProfile.interests
        });
        profileToLike.markModified('wholikeyou');
         
        userProfile.markModified('whoyoulike');
        
        await userProfile.save();
        await profileToLike.save();

        
        acc.numberlike-=1;
        await acc.save();
        return res.status(200).json({ profile: userProfile });  
    } catch (err) {  
        return res.status(400).json({ error: err.message });  
    }  
};

exports.superlikeProfile = async (req, res) => {
    const {accountId} = req.params;
    const {profileId} = req.body;
    try{
        const acc=await Account.findById(new mongoose.Types.ObjectId(accountId));
        if (!acc) {
            return res.status(404).json({ message: 'Account not found' });
        }
        if(acc.numbersuperlike==0){
            return res.status(400).json({message: 'Out of superlikes'});
        }
        const profileToLike = await Profile.findOne({ accountId: profileId });  
        if (!profileToLike) {  
            return res.status(404).json({ message: 'Profile not found' });  
        }  

        const userProfile = await Profile.findOne({ accountId: accountId });  
        if (!userProfile) {  
            return res.status(404).json({ message: 'User not found' });  
        }  

        if (userProfile.whoyousuperlike.some(profile => profile.accountId === profileId)) {  
            return res.status(400).json({ message: 'Profile already super liked' });  
        }  
        if(userProfile.whoyoulike.some(profile => profile.accountId === profileId)){
            userProfile.whoyoulike = userProfile.whoyoulike.filter(profile => profile.accountId !== profileId);
            profileToLike.wholikeyou = profileToLike.wholikeyou.filter(profile => profile.accountId !== accountId);
            userProfile.markModified('whoyoulike');
            profileToLike.markModified('wholikeyou');
        }
        if (userProfile.whoyouskip.some(profile => profile.accountId === profileId)) {  
            userProfile.whoyouskip = userProfile.whoyouskip.filter(profile => profile.accountId!== profileId);
            userProfile.markModified('whoyouskip');
        }

        userProfile.whoyousuperlike.push({
            accountId: profileToLike.accountId,
            name: profileToLike.name,
            birthday: profileToLike.birthday,
            image: profileToLike.images[0],
            priorityDistance: profileToLike.priorityDistance,
            verified: profileToLike.verified,
            findfor: profileToLike.findfor,
            location: profileToLike.location,
            interests: profileToLike.interests
        }); 
        profileToLike.whosuperlikeyou.push({
            accountId: userProfile.accountId,
            name: userProfile.name,
            birthday: userProfile.birthday,
            image: userProfile.images[0],
            priorityDistance: userProfile.priorityDistance,
            verified: userProfile.verified,
            findfor: userProfile.findfor,
            location: userProfile.location,
            interests: profileToLike.interests
        });
        profileToLike.markModified('whosuperlikeyou');
         
        userProfile.markModified('whoyousuperlike');
        
        await userProfile.save();
        await profileToLike.save();
        acc.numbersuperlike-=1;
        await acc.save();
        return res.status(200).json({ profile: userProfile });
    }catch(err){
        return res.status(400).json({error: err.message});
    }
};
exports.skipProfile = async (req, res) => {
    const {accountId} = req.params;
    const {profileId} = req.body;
    try{
        const profileToLike = await Profile.findOne({ accountId: profileId });  
        if (!profileToLike) {  
            return res.status(404).json({ message: 'Profile not found' });  
        }  

        const userProfile = await Profile.findOne({ accountId: accountId });  
        if (!userProfile) {  
            return res.status(404).json({ message: 'User not found' });  
        }  
        if(userProfile.whoyousuperlike.some(profile => profile.accountId === profileId)){
            userProfile.whoyousuperlike = userProfile.whoyousuperlike.filter(profile => profile.accountId !== profileId);
            profileToLike.whosuperlikeyou = profileToLike.whosuperlikeyou.filter(profile => profile.accountId !== accountId);
            userProfile.markModified('whoyousuperlike');
            profileToLike.markModified('whosuperlikeyou');
        }
        if (userProfile.whoyoulike.some(profile => profile.accountId === profileId)) {  
            userProfile.whoyoulike = userProfile.whoyoulike.filter(profile => profile.accountId!== profileId);
            profileToLike.wholikeyou = profileToLike.wholikeyou.filter(profile => profile.accountId !== accountId);
            userProfile.markModified('whoyouskip');
            profileToLike.markModified('wholikeyou');
        }     

        userProfile.whoyouskip.push({
            accountId: profileToLike.accountId,
            name: profileToLike.name,
            birthday: profileToLike.birthday,
            image: profileToLike.images[0],
            priorityDistance: profileToLike.priorityDistance,
            verified: profileToLike.verified,
            findfor: profileToLike.findfor,
            location: profileToLike.location,
            interests: profileToLike.interests

        }); 
        
         
        userProfile.markModified('whoyouskip');
        
        await userProfile.save();
        await profileToLike.save();
        return res.status(200).json({ profile: userProfile }); 
    }catch(err){
        return res.status(400).json({error: err.message});
    }
};
exports.getWhoYouLike = async (req, res) => {
    const {accountId} = req.params;
    try{
        const userProfile = await Profile.findOne({ accountId: accountId });
        if (!userProfile) {
            return res.status(404).json({ message: 'User not found' });
        }
        const WYSL= userProfile.whoyousuperlike;
        const WYL= userProfile.whoyoulike;
        return res.status(200).json({whoyoulike: WYL, whoyousuperlike: WYSL});
    }catch(err){
        return res.status(400).json({error: err.message});
    }
};
exports.getWhoLikeYou = async (req, res) => {
    const {accountId} = req.params;
    try{
        const userProfile = await Profile.findOne({ accountId: accountId });
        if (!userProfile) {
            return res.status(404).json({ message: 'User not found' });
        }
        const WSL= userProfile.whosuperlikeyou;
        const WL= userProfile.wholikeyou;
        return res.status(200).json({wholikeyou: WL, whosuperlikeyou: WSL});
    }
    catch(err){
        return res.status(400).json({error: err.message});
    }
};
exports.getWhoYouSkip = async (req, res) => {
    const {accountId} = req.params;
    try{
        const userProfile = await Profile.findOne({ accountId: accountId });
        if (!userProfile) {
            return res.status(404).json({ message: 'User not found' });
        }
        const WS= userProfile.whoyouskip;
        return res.status(200).json({whoyouskip: WS});
    }
    catch(err){
        return res.status(400).json({error: err.message});
    }
};

exports.actiSpeed = async (req, res) => {
    const {accountId} = req.params;
    try{
        const Acc=await Account.findById(accountId);
        if (!Acc) {
            return res.status(404).json({ message: 'Account not found' });
        }
        if(Acc.numberspeed==0){
            return res.status(400).json({message: 'Out of speed'});
        }
        const userProfile = await Profile.findOne({ accountId: accountId });
        if (!userProfile) {
            return res.status(404).json({ message: 'User not found' });
        }
        userProfile.isSpeed=true;
        const now = Date.now();
        let remain =0;
        if(userProfile.expireSpeed > now){
            remain = userProfile.expireSpeed - now;
        }
        userProfile.expireSpeed= new Date(now + 5*60*60*1000 + remain);

        await userProfile.save();
        return res.status(200).json({profile: userProfile});
    }catch(err){
        return res.status(400).json({error: err.message});
    }
}