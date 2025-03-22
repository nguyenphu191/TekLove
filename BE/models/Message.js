const mongoose = require('mongoose');

const messageSchema = new mongoose.Schema({
    sender: {type: mongoose.Schema.Types.Mixed, required: true},
    receiver: {type: mongoose.Schema.Types.Mixed, required: true},
    content: {type: String, required: true},
    imageUrl: {type: [String]},
    createdAt: {type: Date, default: Date.now},
    isread: {type: Boolean, default: false}
});

module.exports = mongoose.model('Message', messageSchema);