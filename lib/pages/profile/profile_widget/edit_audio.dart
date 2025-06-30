import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class EditAudio extends StatefulWidget {
  const EditAudio({super.key});

  @override
  State<EditAudio> createState() => _EditAudioState();
}

class _EditAudioState extends State<EditAudio> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool imgSmart = false;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  @override
  void initState() {
    super.initState();
    // Lắng nghe luồng vị trí hiện tại
    _audioPlayer.onPositionChanged.listen((Duration duration) {
      setState(() {
        _currentPosition = duration;
      });
    });

    // Lắng nghe luồng tổng thời lượng
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    // Lắng nghe sự kiện hoàn tất phát
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _currentPosition = Duration.zero;
      });
    });
  }

  Future<void> _playPause() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        print("Đã tạm dừng phát.");
      } else {
        await _audioPlayer.play(AssetSource('audio/let-it-go-12279.mp3'));
        print("Âm thanh đang phát.");
      }
      setState(() {
        _isPlaying = !_isPlaying;
      });
    } catch (e) {
      print("Lỗi phát âm thanh: $e");
    }
  }

  Future<void> _seek(double value) async {
    final position = Duration(seconds: value.toInt());
    await _audioPlayer.seek(position);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      final profile = profileProvider.profile;
      if (profile == null) {
        return Center(child: CircularProgressIndicator());
      }
      return Column(
        children: [
          Container(
            height: 242 * pix,
            width: size.width,
            padding: EdgeInsets.all(16 * pix),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  height: 58 * pix,
                  width: size.width - 32 * pix,
                  child: Column(
                    children: [
                      Container(
                        height: 18 * pix,
                        width: size.width - 32 * pix,
                        child: Text(
                          'Audio giới thiệu bản thân',
                          style: TextStyle(
                              fontSize: 13 * pix,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BeVietnamPro'),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: 40 * pix,
                        width: size.width - 32 * pix,
                        child: Text(
                          'Bản ghi âm giới thiệu về bản thân bạn không dài quá 30 giây, được phát dưới nền ảnh của bạn.',
                          style: TextStyle(
                              fontSize: 12 * pix, fontFamily: 'BeVietnamPro'),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8 * pix),
                Container(
                  height: 66 * pix,
                  width: size.width - 32 * pix,
                  padding: EdgeInsets.only(left: 8 * pix, right: 8 * pix),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          if (profile.voices.length == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Chưa có file âm thanh nào'),
                            ));
                          } else {
                            _playPause();
                          }
                        },
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            _isPlaying
                                ? Icons.pause_outlined
                                : Icons.play_arrow_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 16 * pix,
                          ),
                          Container(
                            height: 24 * pix,
                            width: 253 * pix,
                            decoration: BoxDecoration(),
                            child: _isPlaying == true
                                ? SoundWaveWidget()
                                : Image.asset(AppImages.wave),
                          ),
                          Container(
                            height: 16 * pix,
                            width: 253 * pix,
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Text(
                                  _formatDuration(
                                    _currentPosition,
                                  ),
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12 * pix),
                                ),
                                Text(' / ',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12 * pix)),
                                Text(
                                  _formatDuration(_totalDuration),
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12 * pix),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.close,
                            color: AppColors.primary,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8 * pix),
                Container(
                  height: 70 * pix,
                  width: size.width - 32 * pix,
                  child: Row(
                    children: [
                      Container(
                        height: 65 * pix,
                        width: 30 * pix,
                        alignment: Alignment.topCenter,
                        child: Transform.scale(
                          scale:
                              0.6, // Giảm kích thước, giá trị < 1 làm nhỏ hơn, giá trị > 1 làm lớn hơn
                          child: Switch(
                            value: imgSmart,
                            onChanged: (value) {
                              setState(() {
                                imgSmart = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10 * pix),
                      Container(
                        height: 70 * pix,
                        width: size.width - 72 * pix,
                        padding: EdgeInsets.only(top: 10 * pix),
                        child: Column(
                          children: [
                            Container(
                              height: 20 * pix,
                              width: size.width - 72 * pix,
                              child: Text(
                                'Tự động phát',
                                style: TextStyle(
                                    fontSize: 13 * pix,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BeVietnamPro'),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: 40 * pix,
                              width: size.width - 72 * pix,
                              child: Text(
                                'Tự động chạy đoạn thoại khi có người xem đến hồ sơ của bạn.',
                                style: TextStyle(
                                    fontSize: 12 * pix,
                                    fontFamily: 'BeVietnamPro'),
                                textAlign: TextAlign.left,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1 * pix,
            width: size.width,
            color: Colors.grey,
          ),
          Container(
            height: 144 * pix,
            width: size.width,
            color: Colors.white,
            padding:
                EdgeInsets.only(left: 16 * pix, right: 16 * pix, top: 16 * pix),
            child: Column(
              children: [
                Container(
                  height: 58 * pix,
                  width: size.width - 32 * pix,
                  child: Column(
                    children: [
                      Container(
                        height: 18 * pix,
                        width: size.width - 32 * pix,
                        child: Text(
                          'Audio giới thiệu bản thân',
                          style: TextStyle(
                              fontSize: 13 * pix,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BeVietnamPro'),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        height: 40 * pix,
                        width: size.width - 32 * pix,
                        child: Text(
                          'Bản ghi âm giới thiệu về bản thân bạn không dài quá 30 giây, được phát dưới nền ảnh của bạn.',
                          style: TextStyle(
                              fontSize: 12 * pix, fontFamily: 'BeVietnamPro'),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8 * pix),
                Container(
                  height: 48 * pix,
                  width: size.width - 32 * pix,
                  padding: EdgeInsets.only(left: 90 * pix, right: 8 * pix),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 190, 206).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.iconMicrophone,
                        height: 24 * pix,
                        width: 24 * pix,
                      ),
                      SizedBox(width: 8 * pix),
                      Text(
                        'Bấm giữ để ghi âm',
                        style: TextStyle(
                            fontSize: 14 * pix,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'BeVietnamPro'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1 * pix,
            width: size.width,
            color: Colors.grey,
          ),
        ],
      );
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds % 60);
    return '$minutes:$seconds';
  }
}

class SoundWaveWidget extends StatefulWidget {
  @override
  _SoundWaveWidgetState createState() => _SoundWaveWidgetState();
}

class _SoundWaveWidgetState extends State<SoundWaveWidget> {
  List<double> amplitudes = List.generate(30, (index) => Random().nextDouble());

  @override
  void initState() {
    super.initState();
    // Tạo hiệu ứng động bằng cách cập nhật amplitudes mỗi 100ms
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        // Thay đổi giá trị biên độ ngẫu nhiên hoặc từ FFT
        amplitudes = List.generate(30, (index) => Random().nextDouble());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300, 100),
      painter: SoundWavePainter(amplitudes),
    );
  }
}

class SoundWavePainter extends CustomPainter {
  final List<double> amplitudes;

  SoundWavePainter(this.amplitudes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    final barCount = amplitudes.length; // Số lượng thanh sóng
    final barWidth = size.width / barCount; // Độ rộng mỗi thanh
    final centerY = size.height / 2; // Vị trí trung tâm theo trục Y

    for (int i = 0; i < barCount; i++) {
      final barHeight = amplitudes[i] * size.height;

      // Tính vị trí của thanh sóng
      final x = i * barWidth + barWidth / 2;

      // Vẽ thanh sóng
      canvas.drawLine(
        Offset(x, centerY - barHeight / 2),
        Offset(x, centerY + barHeight / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
