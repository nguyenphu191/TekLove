import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String img;
  final VoidCallback onDelete;

  const ImageBox({required this.img, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(File(img)), // Hiển thị ảnh từ file
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 5 * pix,
          right: 5 * pix,
          child: Container(
            height: 25 * pix,
            width: 25 * pix,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 162, 160, 160).withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
            ),
            child: GestureDetector(
              onTap: onDelete,
              child: const Icon(Icons.close,
                  color: Color.fromARGB(255, 255, 255, 255), size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
