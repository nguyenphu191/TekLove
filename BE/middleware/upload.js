const multer = require('multer');
const path = require('path');

// Cấu hình lưu trữ cho hình ảnh, video và voice
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        if (file.mimetype.startsWith('image/')) {
            cb(null, 'uploads/images/');
        } else if (file.mimetype.startsWith('video/')) {
            cb(null, 'uploads/videos/');
        } else if (file.mimetype.startsWith('audio/')) {
            cb(null, 'uploads/voices/');
        } else {
            cb(new Error('File type not supported'), false);
        }
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
    }
});

// Bộ lọc file (cho phép hình ảnh, video và voice)
const fileFilter = (req, file, cb) => {
    if (file.mimetype.startsWith('image/') || file.mimetype.startsWith('video/') || file.mimetype.startsWith('audio/')) {
        cb(null, true);
    } else {
        cb(new Error('File type not supported'), false);
    }
};

// Giới hạn kích thước file (Video: 100MB, Voice: 10MB)
const upload = multer({
    storage: storage,
    fileFilter: fileFilter,
    limits: { fileSize: 100 * 1024 * 1024 } // 100MB
});

module.exports = upload;