const socketIo = require('socket.io');
const http = require('http');
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const dotenv = require('dotenv');
const AccountRoute = require('./routes/AccountRoute');
const ProfileRoute = require('./routes/ProfileRoute');
const MessageRoute = require('./routes/MessageRoute');
const LoveRoute = require('./routes/LoveRoute');
const ServiceRoute = require('./routes/ServiceRoute');
const BillServiceRoute = require('./routes/BillServiceRoute');
require('./utils/cron');
const path = require('path');

dotenv.config(); // Load biến môi trường từ .env

// Khởi tạo Express
const app = express();

// Middleware
app.use(bodyParser.json());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));  // 🔥 Hỗ trợ form data

// Kết nối MongoDB
mongoose
  .connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('✅ Kết nối MongoDB thành công.'))
  .catch((err) => console.error('❌ Lỗi kết nối MongoDB:', err));

// Khởi tạo server HTTP và Socket.IO
const server = http.createServer(app);
const io = socketIo(server);

// Lưu socket.io vào app để sử dụng trong controller
app.set('io', io);

// Socket.IO connection
io.on('connection', (socket) => {
    console.log('✅ User connected:', socket.id);

    socket.on('join', (userId) => {
        socket.join(userId);
        console.log(`✅ User ${userId} đã tham gia phòng.`);
    });

    socket.on('disconnect', () => {
        console.log('❌ User disconnected:', socket.id);
    });
});
// Cung cấp truy cập tĩnh cho thư mục uploads
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
// Routes
app.use('/api/account', AccountRoute);
app.use('/api/profile', ProfileRoute);
app.use('/api/message', MessageRoute);
app.use('/api/love', LoveRoute);
app.use('/api/service', ServiceRoute);
app.use('/api/bill-service', BillServiceRoute);

// Start server
const PORT = process.env.PORT || 5000;
server.listen(PORT, () => console.log(`🚀 Server chạy tại cổng ${PORT}.`));
