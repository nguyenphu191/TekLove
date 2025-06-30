const express = require('express');
const router = express.Router();
const LoveController = require('../controllers/LoveController');

router.post('/send/:senderId',LoveController.send);
router.post('/accept',LoveController.accept);
router.post('/reject/:loveId',LoveController.reject);
router.post('/delete/:userId',LoveController.delete);
router.post('/attend/:userId',LoveController.attend);
router.get('/getLoveInfor/:userId',LoveController.getLoveInfor);
router.get('/check-love/:userId/:candidateId', LoveController.checkLove);

module.exports = router;