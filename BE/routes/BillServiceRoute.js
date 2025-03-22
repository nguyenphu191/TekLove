const express = require('express');
const router = express.Router();
const BillServiceController = require('../controllers/BillServiceController');

//user
router.post('/create-bill', BillServiceController.create);
router.post('/payment-bill/:billId', BillServiceController.payment);
router.delete('/delete-bill/:billId', BillServiceController.delete);
//admin
router.get('/getall', BillServiceController.getAll);

module.exports = router;