import 'package:flutter/material.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/models/candidate.dart';
import 'package:tiklove_fe/res/images/app_images.dart';

class SendGreeting extends StatefulWidget {
  const SendGreeting({super.key, required this.candidate});
  final Profile candidate;
  @override
  State<SendGreeting> createState() => _SendGreetingState();
}

class _SendGreetingState extends State<SendGreeting> {
  PageController pageController = PageController(viewportFraction: 0.85);
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
    pageController.addListener(() {});
    if (!_imageIndices.containsKey(widget.candidate.accountId)) {
      _imageIndices[widget.candidate.accountId] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
                height: 60,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 30,
                          ),
                        ),
                        Text(
                          'Gửi lời chào',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BeVietnamPro'),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Còn 3 ',
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'BeVietnamPro'),
                        ),
                        Image.asset(
                          AppImages.star,
                          width: 30,
                          height: 30,
                        ),
                      ],
                    )
                  ],
                )),
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Container(
              height: 264 * pix,
              width: 361 * pix,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset(
                AppImages.sendGreeting,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 264 * pix + 100,
            left: 0,
            right: 0,
            child: Container(
              height: 336 * pix,
              width: 336 * pix,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: widget.candidate.images.length > 1
                      ? widget.candidate.images.length
                      : 1,
                  itemBuilder: (context, position) {
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: position.isEven
                                ? Color.fromARGB(255, 241, 203, 65)
                                : Color.fromARGB(255, 74, 236, 203),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: widget.candidate.images.isNotEmpty
                              ? Image.network(
                                  widget.candidate.images[position],
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      color: Colors.grey,
                                      child: const Center(
                                        child: Icon(Icons.error,
                                            color: Colors.white),
                                      ),
                                    );
                                  },
                                )
                              : Image.asset(
                                  AppImages.userUnknown,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Container(
                            height: 30,
                            width: 46,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              '${position + 1}/${widget.candidate.images.length}',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'BeVietnamPro',
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
          Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                width: size.width - 20,
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color:
                            Color.fromARGB(255, 211, 211, 211).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Nhập lời chào của bạn',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'BeVietnamPro',
                              color: const Color.fromARGB(255, 121, 121, 121)),
                          contentPadding: EdgeInsets.only(left: 20),
                          border: InputBorder.none,
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:
                            Color.fromARGB(255, 211, 211, 211).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Image.asset(
                          AppImages.sendViolet,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
