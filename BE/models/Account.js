const mongoose = require('mongoose');

const accountSchema = new mongoose.Schema({
    phone: {type: String , required: true},
    password: {type: String , required: true},
    numberlike: {type: Number , default: 10},
    numbersuperlike: {type: Number , default: 3},
    numberspeed:{type: Number , default:0},
    premium: {type: Boolean , default: false, default: false},
    datePremium: {type: Date},
    otp: {type: String },
    otpExpires: {type: Date},
    isActive: {type: Boolean , default: false},
    isOn: {type: Boolean , default: false},
});

module.exports = mongoose.model('Account', accountSchema);