const mongoose = require('mongoose');

exports.create = async (req, res) => {
    try {
        const{accountId, enimyId, content, image} = req.body;
        if(!image){
            const report = await Report.create({accountId, enimyId, content});
            return res.status(200).json(report);
        }else{
            const report = await Report.create({accountId, enimyId, content, image});
            return res.status(200).json(report);
        }
    }
    catch (error) {
        return res.status(500).json({ message: 'L��i khi tạo báo cáo', error });
    }
};