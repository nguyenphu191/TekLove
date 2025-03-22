const mongoose = require('mongoose');
const Service = require('../models/Service');

exports.getAll = async (req, res) => {
    try {
        const services = await Service.find();
        res.status(200).json(services);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
//Admin
exports.create = async (req, res) => {   
    try {
        const { typeService, amount, price, discount, monthPremium } = req.body;
        if(typeService === 'premium' && !monthPremium){
            return res.status(400).json({ message: 'Error without number month for premium' });
        }else if(typeService === 'premium' && monthPremium){
            const service = new Service({
                typeService,
                amount,
                price,
                discount,
                monthPremium,
            });
            await service.save();
            return res.status(200).json(service);
        }
        const service = new Service({
            typeService,
            amount,
            price,
            discount,
        });
        await service.save();
        return res.status(200).json(service);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
exports.delete = async (req, res) => {
    try {
        const { serviceId } = req.params;
        await Service.findByIdAndDelete(serviceId);
        res.status(200).json({ message: 'Xóa thành công' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

exports.update = async (req, res) => {
    try {
        const { serviceId } = req.params;
        const {amount, price, discount } = req.body;
        const updatedService = await Service.findByIdAndUpdate(serviceId, {amount, price, discount }, { new: true });
        res.status(200).json(updatedService);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
