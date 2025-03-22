import 'package:flutter/material.dart';

class AddBox extends StatelessWidget {
  final VoidCallback onTap;

  const AddBox({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            size: 30 * pix,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
