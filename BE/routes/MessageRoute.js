
const express = require('express');
const router = express.Router();
const MessageController = require('../controllers/MessageController');
const path = require('path');
const upload = require('../middleware/upload');

router.post('/send/:userId', upload.array('files', 10),MessageController.send);
router.post('/get/:userId',MessageController.get);
router.get('/getall/:userId',MessageController.getAll);
router.put('/update/:messId',MessageController.update);
router.post('/checkmatch/:userId',MessageController.checkMatch);

module.exports = router;