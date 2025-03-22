const mongoose = require('mongoose');
const BillService= require('../models/BillService');
const Account = require('../models/Account');
const Service = require('../models/Service');

exports.create = async (req, res) => {
    try {
        const { accountId, serviceId, typePayment} = req.body;
        const account = await Account.findById(accountId);
        if (!account) {
            return res.status(404).json({ message: 'Tài khoản không tồn tại' });
        }
        const service = await Service.findById(serviceId);
        if (!service) {
            return res.status(404).json({ message: 'Dịch vụ không tồn tại' });
        }
        let total;
        if(service.typeService!=='premium'){
            total= (service.price * service.amount) * (100-service.discount)/100;
        }else{
            total= service.price  * (100-service.discount)/100;
        }
        const billService = new BillService({
            accountId,
            service,
            typePayment,
            total: total,
        });
        await billService.save();
        res.status(200).json(billService);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
exports.payment = async (req, res) => {
    try { 
        const { billId } = req.params;  
        const bill = await BillService.findById(billId);  
        
        if (!bill) {  
            return res.status(404).json({ message: "Bill not found" });  
        }  
        if (bill.status === 'completed') {  
            return res.status(400).json({ message: "Bill already paid" });  
        }
        // Xử lý thanh toán tại đây (giả sử thanh toán thành công)  
        
        // Cập nhật trạng thái thanh toán  
        const accountId=bill.accountId;
        const account = await Account.findById(accountId);
        bill.status = 'completed';  
        if(bill.service.typeService=='like'){
            account.numberlike+=bill.service.amount;
        }else if(bill.service.typeService=='superlike'){
            account.numbersuperlike+=bill.service.amount;
        }else if(bill.service.typeService=='speed'){
            account.numberspeed+=bill.service.amount;
        }else if(bill.service.typeService=='premium'){
            const now = Date.now();
            if(account.premium==true){
                account.datePremium= (account.datePremium-now)+(bill.service.monthPremium*30*24*60*60*1000);
            }else{
                account.premium=true;
                account.datePremium= now + (bill.service.monthPremium*30*24*60*60*1000);
            }          
        }
        await account.save();
        await bill.save();  

        return res.status(200).json(bill);  
    } catch (error) {  
        res.status(400).send(error);  
    }  
};
exports.delete = async (req, res) => {
    try {
        const { billId } = req.params;
        const bill = await BillService.findById(billId);
        if (!bill) {
            return res.status(404).json({ message: 'Bill not found' });
        }
        if(bill.status==='completed'){
            return res.status(400).json({ message: 'Bill is paid' });
        }
        res.status(200).json({ message: 'Xóa thành công' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
exports.getAll = async (req, res) => {
    try {
        const bills = await BillService.find();
        res.status(200).json(bills);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};