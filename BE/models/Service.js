const mongoose = require('mongoose');

const serviceSchema = new mongoose.Schema({
    typeService:{type: String,enum:['like','superlike','speed','premium'], required: true},
    amount: { type: Number, required: true },
    price: { type: Number, required: true },
    discount: { type: Number, required: true },
    createdAt: { type: Date, default: Date.now },
    monthPremium: { type: Number },
});

module.exports = mongoose.model('Service', serviceSchema);