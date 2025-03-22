const mongoose = require('mongoose');

const SchemaBillService = new mongoose.Schema({
    accountId: {type: String, required: true},
    service: {type: mongoose.Schema.Types.Mixed, required: true},
    status: {type: String, default: 'pending'},
    typePayment: {type: String,enum:['apple','chplay'], required: true},
    total: { type: Number, required: true },
    createdAt: {type: Date, default: Date.now},
});

module.exports = mongoose.model('BillService', SchemaBillService);