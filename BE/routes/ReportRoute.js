const express = require('express');
const router = express.Router();
const ReportController = require('../controllers/ReportController');

router.post('/create', ReportController.create);

module.exports = router;