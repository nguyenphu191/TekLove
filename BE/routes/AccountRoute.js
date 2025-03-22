const express = require('express');
const router = express.Router();
const AccountController = require('../controllers/AccountController');

router.post('/login', AccountController.login);

// Đăng ký người dùng và gửi OTP
router.post('/register', AccountController.register);

// Xác thực OTP
router.post('/verify-otp', AccountController.verifyOtp);
//Admin
router.get('/getall', AccountController.getallAccounts);
router.get('/get/:accountId', AccountController.getAccountById);
router.delete('/delete/:accountId', AccountController.deleteAccount);

module.exports = router;
