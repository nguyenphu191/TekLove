import 'package:flutter/material.dart';
import 'package:tiklove_fe/res/images/app_images.dart';

class BoxInfor extends StatefulWidget {
  const BoxInfor(
      {super.key,
      required this.icon,
      required this.title,
      required this.content,
      required this.callback});
  final String icon;
  final String title;
  final String content;
  final VoidCallback callback;

  @override
  State<BoxInfor> createState() => _BoxInforState();
}

class _BoxInforState extends State<BoxInfor> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      height: 80 * pix,
      width: size.width,
      padding: EdgeInsets.only(
          left: 12 * pix, right: 12 * pix, top: 12 * pix, bottom: 5 * pix),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey),
          )),
      child: Row(
        children: [
          Container(
            height: 42 * pix,
            width: 42 * pix,
            child: Image.asset(
              widget.icon,
              height: 30 * pix,
              width: 30 * pix,
            ),
          ),
          SizedBox(width: 8 * pix),
          Container(
            width: size.width - 112 * pix,
            child: Column(
              children: [
                Container(
                    height: 18 * pix,
                    width: size.width - 112 * pix,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 12 * pix,
                          color: Colors.black,
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                      textAlign: TextAlign.left,
                    )),
                SizedBox(height: 3 * pix),
                widget.content.isNotEmpty
                    ? Container(
                        height: 40 * pix,
                        width: size.width - 108 * pix,
                        padding: EdgeInsets.only(left: 10 * pix),
                        child: Text(
                          widget.content,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: widget.content.length > 30
                                  ? 12 * pix
                                  : 14 * pix,
                              fontFamily: 'BeVietnamPro',
                              overflow: TextOverflow.ellipsis),
                          textAlign: TextAlign.left,
                        ),
                      )
                    : InkWell(
                        child: Container(
                          height: 22 * pix,
                          width: size.width - 108 * pix,
                          padding: EdgeInsets.only(left: 16 * pix),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Thêm ',
                                style: TextStyle(
                                    fontSize: 14 * pix,
                                    fontFamily: 'BeVietnamPro',
                                    overflow: TextOverflow.ellipsis),
                                textAlign: TextAlign.left,
                              ),
                              Icon(
                                Icons.add,
                                color: const Color.fromARGB(255, 26, 26, 26),
                                size: 16 * pix,
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(width: 8 * pix),
          InkWell(
            onTap: widget.callback,
            child: Container(
              height: 30 * pix,
              width: 30 * pix,
              child: Image.asset(
                AppImages.iconchevronright,
                height: 30 * pix,
                width: 30 * pix,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
