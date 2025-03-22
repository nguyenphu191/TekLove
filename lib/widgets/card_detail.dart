import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/utils.dart' as utils;
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({super.key, required this.candidate});
  final Profile candidate;

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  final String imgUrl = utils.imgUrl;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  double _volume = 1.0;
  static final Map<String, int> _imageIndices = {};

  int get currentImage => _imageIndices[widget.candidate.accountId] ?? 0;

  set currentImage(int value) {
    setState(() {
      _imageIndices[widget.candidate.accountId] = value;
    });
  }

  void previousImage() {
    if (currentImage > 0) {
      currentImage = currentImage - 1;
    }
  }

  void nextImage() {
    if (currentImage < widget.candidate.images.length - 1) {
      currentImage = currentImage + 1;
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_imageIndices.containsKey(widget.candidate.accountId)) {
      _imageIndices[widget.candidate.accountId] = 0;
    }
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

  Future<void> _setVolume(double value) async {
    setState(() {
      _volume = value;
    });
    await _audioPlayer.setVolume(value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return SafeArea(
      child: // Avatar và thanh điều khiển
          Center(
        child: Container(
          height: size.height * 0.63,
          width: size.width,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.63,
                width: double.maxFinite,
                child: widget.candidate.images.isNotEmpty
                    ? Image.network(
                        '$imgUrl/${widget.candidate.images[currentImage]}',
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.grey,
                            child: const Center(
                              child: Icon(Icons.error, color: Colors.white),
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        AppImages.userUnknown,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
              ),
              Positioned.fill(
                  child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: previousImage,
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: nextImage,
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                ],
              )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 250 * pix,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                    ],
                  )),
                ),
              ),
              Positioned(
                  bottom: 10 * pix,
                  left: 10 * pix,
                  right: 10 * pix,
                  child: Container(
                    height: 8 * pix,
                    child: widget.candidate.images.length > 1
                        ? Row(
                            children: List.generate(
                                widget.candidate.images.length,
                                (index) => Expanded(
                                      child: Container(
                                        height: 8 * pix,
                                        margin: EdgeInsets.only(
                                            right: index ==
                                                    widget.candidate.images
                                                            .length -
                                                        1
                                                ? 0
                                                : 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                width: 1 * pix,
                                                color: currentImage == index
                                                    ? AppColors.primary
                                                    : const Color(0xffFFFFFF)
                                                        .withOpacity(0.3)),
                                            color: currentImage == index
                                                ? AppColors.primary
                                                : const Color(0xffFFFFFF)
                                                    .withOpacity(0.2)),
                                      ),
                                    )),
                          )
                        : const SizedBox.shrink(),
                  )),
              widget.candidate.voices.length > 0
                  ? Positioned(
                      bottom: 25 * pix,
                      left: 10 * pix,
                      right: 10 * pix,
                      child: Container(
                        height: 36 * pix,
                        width: size.width - 50 * pix,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                _playPause();
                              },
                              child: Container(
                                height: 36 * pix,
                                width: 36 * pix,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 145, 145, 145)
                                      .withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  _isPlaying
                                      ? Icons.pause_outlined
                                      : Icons.play_arrow_outlined,
                                  color: Colors.white,
                                  size: 30 * pix,
                                ),
                              ),
                            ),
                            Container(
                              height: 36 * pix,
                              width: 75 * pix,
                              decoration: BoxDecoration(),
                              child: Row(
                                children: [
                                  Text(
                                    _formatDuration(
                                      _currentPosition,
                                    ),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12 * pix),
                                  ),
                                  Text(' / ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12 * pix)),
                                  Text(
                                    _formatDuration(_totalDuration),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12 * pix),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 20 * pix,
                              width: 184 * pix,
                              decoration: BoxDecoration(),
                              child: _isPlaying == true
                                  ? SoundWaveWidget()
                                  : Image.asset(AppImages.wave),
                            ),
                            Container(
                              height: 36 * pix,
                              width: 36 * pix,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 145, 145, 145)
                                    .withOpacity(0.7),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.volume_up,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
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
