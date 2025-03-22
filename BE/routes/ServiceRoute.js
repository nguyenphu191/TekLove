const express = require('express');
const router = express.Router();
const ServiceController = require('../controllers/ServiceController');
router.get('/getall', ServiceController.getAll);
router.post('/create', ServiceController.create);
router.delete('/delete/:serviceId', ServiceController.delete);
router.put('/update/:serviceId', ServiceController.update);

module.exports = router;