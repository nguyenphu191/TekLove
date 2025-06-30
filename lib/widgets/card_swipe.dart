import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/pages/home/detail.dart';
import 'package:tiklove_fe/utils.dart' as utils;

import 'package:flutter/material.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:intl/intl.dart';
import '../res/fonts/app_fonts.dart';
import '../theme/app_colors.dart';

class SwipeCard extends StatefulWidget {
  const SwipeCard(
      {super.key,
      required this.candidate,
      this.onLike,
      this.onNope,
      this.onSuperLike,
      this.like,
      this.nope,
      this.superLike});

  final Profile candidate;
  final Function()? onLike;
  final Function()? onNope;
  final Function()? onSuperLike;
  final bool? like;
  final bool? superLike;
  final bool? nope;

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  final String baseurl = utils.imgUrl;
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

  int calculateAge(String birthDate) {
    DateTime birth = DateFormat('dd/MM/yyyy').parse(birthDate);
    DateTime today = DateTime.now();
    int age = today.year - birth.year;

    // Kiểm tra xem ngày sinh đã qua chưa trong năm hiện tại
    if (today.month < birth.month ||
        (today.month == birth.month && today.day < birth.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      width: size.width,
      height: size.height * 0.7,
      decoration: BoxDecoration(
        color: const Color(0xFF2E3236),
        border: Border.all(
          color: const Color(0xFFFF7A9C),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF295F).withOpacity(0.3),
            blurRadius: 35.2,
            spreadRadius: 0,
            offset: const Offset(0, 8.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
              child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            child: Stack(
              children: [
                widget.candidate.images.isNotEmpty
                    ? Image.network(
                        '$baseurl/${widget.candidate.images[currentImage]}',
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
                Positioned.fill(
                  child: widget.like == true
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            AppImages.likeEmoji,
                            width: 211.55 * (size.width / 393),
                            fit: BoxFit.fitWidth,
                          ),
                        )
                      : widget.nope == true
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                AppImages.nopeEmoji,
                                width: 267 * (size.width / 393),
                                fit: BoxFit.fitWidth,
                              ),
                            )
                          : widget.superLike == true
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    AppImages.superLikeEmoji,
                                    width: 211.55 * (size.width / 393),
                                    fit: BoxFit.fitWidth,
                                  ),
                                )
                              : const SizedBox.shrink(),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: widget.like == true
                          ? const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0x00212529),
                                Color(0xFF004A29),
                              ],
                              stops: [0.5754, 1.0],
                            )
                          : widget.nope == true
                              ? const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0x00212529),
                                    Color(0xFF6C000B),
                                  ],
                                  stops: [0.5754, 1.0],
                                )
                              : widget.superLike == true
                                  ? const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(
                                            0x00212529), // rgba(33, 37, 41, 0)
                                        Color(0xFF01438F), // #01438F
                                      ],
                                      stops: [
                                        0.5754,
                                        1.0
                                      ], // Dừng gradient tại các điểm tương ứng
                                    )
                                  : const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0x00212529),
                                        Color(0xFF2E3236),
                                      ],
                                      stops: [0.5754, 1.0],
                                    ),
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Padding(
                  padding: EdgeInsets.all(10 * pix),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.candidate.images.length > 1
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
                                                  width: 1,
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
                      widget.candidate.images.length > 1
                          ? SizedBox(
                              height: 8 * pix,
                            )
                          : const SizedBox.shrink(),
                      widget.candidate.voices.length > 0
                          ? Positioned(
                              bottom: 25 * pix,
                              left: 10 * pix,
                              right: 10 * pix,
                              child: Container(
                                height: 36 * pix,
                                width: size.width - 50 * pix,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _playPause();
                                      },
                                      child: Container(
                                        height: 36 * pix,
                                        width: 36 * pix,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[600]!
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                          : Image.asset(
                                              AppImages.wave,
                                            ),
                                    ),
                                    Container(
                                      height: 36 * pix,
                                      width: 36 * pix,
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.grey[600]!.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.volume_up,
                                          color: Colors.white,
                                          size: 25 * pix,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          : const SizedBox.shrink(),
                      Expanded(
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
                      SizedBox(
                        height: 4 * pix,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.candidate.name,
                                    style: AppFonts.be600(
                                        24 * pix, AppColors.background),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: 4 * pix,
                                ),
                                Text(
                                    calculateAge(widget.candidate.birthday)
                                        .toString(),
                                    style: AppFonts.be500(
                                        24 * pix, AppColors.background),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                SizedBox(
                                  width: 4 * pix,
                                ),
                                Image.asset(
                                  AppImages.iconVerify,
                                  width: 24 * pix,
                                  height: 24 * pix,
                                ),
                                SizedBox(
                                  width: 4 * pix,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                            candidate: widget.candidate,
                                            isMyProfile: false,
                                          )));
                            },
                            child: Container(
                                padding: EdgeInsets.all(8 * pix),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1,
                                        color: const Color(0xffFFFFFF)
                                            .withOpacity(0.1)),
                                    color: const Color(0xff000000)
                                        .withOpacity(0.1)),
                                child: Image.asset(
                                  AppImages.iconEye,
                                  width: 20 * pix,
                                  height: 20 * pix,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4 * pix,
                      ),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: widget.candidate.interests.length > 5
                            ? List.generate(
                                5,
                                (index) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    index == 4
                                        ? Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: const Color(
                                                              0xffFFFFFF)
                                                          .withOpacity(0.2)),
                                                  color: const Color(0xffFFFFFF)
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 2),
                                              child: Text(
                                                widget
                                                    .candidate.interests[index],
                                                style: AppFonts.be400(
                                                    12, AppColors.background),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        const Color(0xffFFFFFF)
                                                            .withOpacity(0.2)),
                                                color: const Color(0xffFFFFFF)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 2),
                                            child: Text(
                                              widget.candidate.interests[index],
                                              style: AppFonts.be400(
                                                  12, AppColors.background),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                    index == 4
                                        ? SizedBox(
                                            width: 4 * pix,
                                          )
                                        : const SizedBox.shrink(),
                                    index == 4
                                        ? Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1 * pix,
                                                    color:
                                                        const Color(0xffFFFFFF)
                                                            .withOpacity(0.2)),
                                                color: const Color(0xffFFFFFF)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 2),
                                            child: Text(
                                              "+${widget.candidate.interests.length - 5}",
                                              style: AppFonts.be400(
                                                  12, AppColors.background),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              )
                            : List.generate(
                                widget.candidate.interests.length,
                                (index) => Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1 * pix,
                                          color: const Color(0xffFFFFFF)
                                              .withOpacity(0.2)),
                                      color: const Color(0xffFFFFFF)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  child: Text(
                                    widget.candidate.interests[index],
                                    style: AppFonts.be400(
                                        12 * pix, AppColors.background),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          )),
          Container(
            height: 1 * pix,
            color: const Color(0xffFFFFFF).withOpacity(0.1),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttonSwipe(
                    horizontalRatio: pix,
                    icon: AppImages.replay,
                    onTap: () {},
                    isSmaller: true),
                buttonSwipe(
                    horizontalRatio: pix,
                    icon: AppImages.xRed,
                    onTap: widget.onNope,
                    choose: widget.nope == true,
                    isSmaller: false),
                buttonSwipe(
                    horizontalRatio: pix,
                    icon: AppImages.star,
                    onTap: widget.onSuperLike,
                    choose: widget.superLike == true,
                    isSmaller: true),
                buttonSwipe(
                    horizontalRatio: pix,
                    icon: AppImages.loveGreen,
                    onTap: widget.onLike,
                    choose: widget.like == true,
                    isSmaller: false),
                buttonSwipe(
                    horizontalRatio: pix,
                    icon: AppImages.sendViolet,
                    onTap: () {},
                    isSmaller: true),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
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

Widget buttonSwipe(
    {required double horizontalRatio,
    required String icon,
    Function()? onTap,
    required bool isSmaller,
    bool? choose}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      constraints: BoxConstraints(
          maxWidth: (isSmaller ? 48 : 64) * horizontalRatio,
          maxHeight: (isSmaller ? 48 : 64) * horizontalRatio),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            width: 1,
            color: choose == true
                ? Colors.white
                : const Color(0xffFFFFFF).withOpacity(0.1)),
        color: choose == true
            ? Colors.white
            : const Color(0xffFFFFFF).withOpacity(0.1),
      ),
      alignment: Alignment.center,
      child: Image.asset(
        icon,
        width: (isSmaller ? 24 : 32) * horizontalRatio,
        height: (isSmaller ? 24 : 32) * horizontalRatio,
      ),
    ),
  );
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
