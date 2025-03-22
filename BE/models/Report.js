const mongoose = require('mongoose');

const SchemaReport = new mongoose.Schema({
    accountId: {type: String, required: true},
    enimyId: {type: String, required: true},
    content: {type: String, required: true},
    image: {type: String},
    createdAt: {type: Date, default: Date.now},
});

module.exports = mongoose.model('Report', SchemaReport);