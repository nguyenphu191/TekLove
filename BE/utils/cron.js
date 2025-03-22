const cron = require('node-cron');
const Account = require('../models/Account');
const Profile = require('../models/Profile');
cron.schedule('0 0 * * *', async () => {
    try {
        await Account.updateMany(
            {}, 
            { 
                $set: {numberlike: 10}
            }
        );
        console.log('✅ Năng lượng đã được reset cho tất cả người dùng');
    } catch (error) {
        console.error('❌ Lỗi khi reset năng lượng:', error);
    }
});

cron.schedule('*/10 * * * *', async () => {
    const now = new Date();
    try {
        const expiredProfiles = await Profile.updateMany(
            { isSpeed: true, expireSpeed: { $lte: now } },
            { isSpeed: false, expireSpeed: null }
        );
        console.log(`${expiredProfiles.nModified} hồ sơ đã hết hạn tăng tốc.`);
    } catch (error) {
        console.error('Lỗi khi xử lý trạng thái tăng tốc:', error);
    }
});
module.exports = cron;