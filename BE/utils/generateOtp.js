const generateOtp = () => Math.floor(100000 + Math.random() * 900000); // Tạo OTP 6 chữ số
module.exports = generateOtp;
