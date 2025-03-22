const twilio = require('twilio');
const bcrypt = require('bcryptjs');
const Account = require('../models/Account');

// Khởi tạo Twilio Client
const accountSid = "ACec500b9e6271fdf4b425ddab54d49f18";
const authToken = "8972882620439da3485a991eb0c2ef15";
const client = twilio(accountSid, authToken);
const Profile = require('../models/Profile');

// const sendOtp = async (phone) => {  
//   const formattedPhone = phone.startsWith('+') ? phone : `+84${phone.slice(1)}`;  
//   try {  
//     await client.verify.v2.services("VAc1160d5d1196944b6fefe7fdedd16fc2")  
//       .verifications  
//       .create({to: formattedPhone, channel: 'sms'});  
//     console.log(`OTP sent to ${formattedPhone}`);  
//   } catch (err) {  
//     console.error('Error sending OTP:', err);  
//   }  
// };  

exports.register = async (req, res) => {
  const { phone, password } = req.body;

  try {
    // Kiểm tra nếu người dùng đã tồn tại
    const existingAccount = await Account.findOne({ phone });
    if (existingAccount) {
      return res.status(400).json({ message: 'Account already exists' });
    }

    const otp = Math.floor(100000 + Math.random() * 900000).toString();

    // await sendOtp(phone);

    // Lưu người dùng tạm thời với OTP và thời gian hết hạn
    const newAccount = new Account({
      phone,
      password: await bcrypt.hash(password, 10),
      otp,
      otpExpires: Date.now() + 10 * 60 * 1000, 
      isActive: true,
    });

    await newAccount.save();

    return res.status(200).json({account: newAccount});
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
};

// Xác thực OTP và đăng nhập
exports.verifyOtp = async (req, res) => {
  const { AccountId, otp } = req.body;

  try {
    const Acc = await Account.findById(AccountId);

    if (!Acc) {
      return res.status(404).json({ message: 'Account not found' });
    }

    // Kiểm tra OTP và thời gian hết hạn
    if (Acc.otp !== otp) {
      return res.status(400).json({ message: 'Invalid OTP' });
    }

    if (Acc.otpExpires < Date.now()) {
      return res.status(400).json({ message: 'OTP expired' });
    }

    Acc.otp = null;
    Acc.otpExpires = null;
    Acc.isActive = true;
    await Acc.save();

    res.status(200).json({ message: 'OTP verified successfully', account: Acc });

  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
};

// Đăng nhập
exports.login = async (req, res) => {
  const { phone, password } = req.body;

  try {
    const Acc =await Account.findOne({ phone: phone });
    if (!Acc) {
      return res.status(404).json({ message: 'Account not found' });
    }
    // if (!Acc.isActive) {
    //   return res.status(403).json({ message: 'Account is inactive' });
    // }
    const isMatch = await bcrypt.compare(password, Acc.password);
    if (!isMatch) {
      return res.status(400).json({ message: 'Invalid credentials' });
    }
    Acc.isOn=true;
    await Acc.save();
    const profile = await Profile.findOne({ accountId: Acc._id });
    if (!profile) {
      return res.status(201).json({ message: 'noprofile', account: Acc});
    }else if (profile.images.length === 0) {
      return res.status(201).json({ message: 'noimage', account: Acc});
    }
    return res.status(200).json({ message: 'Login successfully', account: Acc });
  }
  catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
};

//Admin
exports.getAccountById = async (req, res) => {
  const { accountId } = req.params;
  try {
    const account = await Account.findById(accountId);
    if (!account) {
      return res.status(404).json({ message: 'Account not found' });
    }
    return res.status(200).json({ account: account });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
};
exports.getallAccounts = async (req, res) => {
  try {
    const accounts = await Account.find();
    return res.status(200).json({ accounts: accounts });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
};

exports.deleteAccount = async (req, res) => {
  const { accountId } = req.params;
  try {
    const account = await Account.findById(accountId);
    if (!account) {
      return res.status(404).json({ message: 'Account not found' });
    }
    await account.remove();
    return res.status(200).json({ message: 'Account deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
    
  }
};