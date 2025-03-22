const mongoose = require('mongoose');

const loveSchema = new mongoose.Schema({
    sender: {type: mongoose.Schema.Types.Mixed, required: true},
    receiver: {type: mongoose.Schema.Types.Mixed, required: true},
    status: {type: String, default: 'pending'},
    
    attendence:{type: Number, default: 0}  ,
    createdAt: {type: Date, default: Date.now},
    updatedAt: {type: Date, default: Date.now},
});

module.exports = mongoose.model('Love', loveSchema);