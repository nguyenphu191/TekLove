class SwipeCandidateModel {
  final String id;
  final String name;
  final List<String> image;
  final int age;
  final String city;
  final String distance;
  final List<String> hobbies;
  final String? audio;

  SwipeCandidateModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.age,
      required this.city,
      required this.distance,
      required this.hobbies,
      this.audio});
}
// Stack(
//                         children: [
//                           Container(
//                             height: size.height * 0.63,
//                             width: double.maxFinite,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20),
//                               ),
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                     users[currentIndex]['image']!), // Hình ảnh
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: size.height * 0.63,
//                             width: double.maxFinite,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20),
//                               ),
//                               color: currentIndex != index
//                                   ? Colors.black.withOpacity(0.5)
//                                   : Colors.transparent,
//                             ),
//                           ),
//                           Positioned(
//                               top: 10,
//                               left: 10,
//                               right: 10,
//                               child: Container(
//                                 height: 8,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/Teklove/TRANSFERBAR.png'),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               )),
//                           Positioned(
//                               top: 25,
//                               left: 10,
//                               child: Container(
//                                 height: 36,
//                                 width: size.width - 50,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         _playPause();
//                                       },
//                                       child: Container(
//                                         height: 36,
//                                         width: 36,
//                                         decoration: BoxDecoration(
//                                           color:
//                                               Color.fromARGB(255, 145, 145, 145)
//                                                   .withOpacity(0.7),
//                                           borderRadius:
//                                               BorderRadius.circular(50),
//                                         ),
//                                         child: Icon(
//                                           _isPlaying
//                                               ? Icons.pause_outlined
//                                               : Icons.play_arrow_outlined,
//                                           color: Colors.white,
//                                           size: 30,
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       height: 36,
//                                       width: 75,
//                                       decoration: BoxDecoration(),
//                                       child: Row(
//                                         children: [
//                                           Text(
//                                             _formatDuration(
//                                               _currentPosition,
//                                             ),
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12),
//                                           ),
//                                           Text(' / ',
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 12)),
//                                           Text(
//                                             _formatDuration(_totalDuration),
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       height: 20,
//                                       width: 184,
//                                       decoration: BoxDecoration(),
//                                       child: _isPlaying == true
//                                           ? SoundWaveWidget()
//                                           : SizedBox(
//                                               height: 0,
//                                             ),
//                                     ),
//                                     Container(
//                                       height: 36,
//                                       width: 36,
//                                       decoration: BoxDecoration(
//                                         color:
//                                             Color.fromARGB(255, 145, 145, 145)
//                                                 .withOpacity(0.7),
//                                         borderRadius: BorderRadius.circular(50),
//                                       ),
//                                       child: InkWell(
//                                         onTap: () {},
//                                         child: Icon(
//                                           Icons.volume_up,
//                                           color: Colors.white,
//                                           size: 25,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                           Positioned(
//                             bottom: 0,
//                             left: 0,
//                             right: 0,
//                             child: Container(
//                               height: 250,
//                               width: double.maxFinite,
//                               decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   Colors.transparent,
//                                   status == ''
//                                       ? const Color.fromARGB(255, 0, 0, 0)
//                                           .withOpacity(0.8)
//                                       : status == "like"
//                                           ? const Color.fromARGB(
//                                                   255, 39, 160, 43)
//                                               .withOpacity(0.8)
//                                           : status == "superlike"
//                                               ? const Color.fromARGB(
//                                                       255, 12, 111, 193)
//                                                   .withOpacity(0.8)
//                                               : const Color.fromARGB(
//                                                       255, 186, 31, 20)
//                                                   .withOpacity(0.8),
//                                 ],
//                               )),
//                             ),
//                           ),
//                           status == ''
//                               ? SizedBox(
//                                   height: 0,
//                                 )
//                               : status == 'like'
//                                   ? Positioned(
//                                       top: size.height * 0.75 / 2,
//                                       left: 50,
//                                       child: AnimatedOpacity(
//                                         opacity: _isVisible ? 1.0 : 0.0,
//                                         duration: Duration(milliseconds: 500),
//                                         child: Container(
//                                           height: 90,
//                                           width: 275,
//                                           decoration: BoxDecoration(
//                                             image: DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/images/Teklove/Emoji.png'),
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                       ))
//                                   : status == 'superlike'
//                                       ? Positioned(
//                                           top: size.height * 0.65 / 2,
//                                           left: 50,
//                                           child: AnimatedOpacity(
//                                             opacity: _isVisible ? 1.0 : 0.0,
//                                             duration:
//                                                 Duration(milliseconds: 500),
//                                             child: Container(
//                                               height: 150,
//                                               width: 275,
//                                               decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                   image: AssetImage(
//                                                       'assets/images/Teklove/Emoji (2).png'),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                             ),
//                                           ))
//                                       : Positioned(
//                                           top: size.height * 0.75 / 2,
//                                           left: 50,
//                                           child: AnimatedOpacity(
//                                             opacity: _isVisible ? 1.0 : 0.0,
//                                             duration:
//                                                 Duration(milliseconds: 500),
//                                             child: Container(
//                                               height: 100,
//                                               width: 290,
//                                               decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                   image: AssetImage(
//                                                       'assets/images/Teklove/Emoji (1).png'),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                           Positioned(
//                             bottom: 83,
//                             left: 10,
//                             right: 10,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       users[currentIndex]['name']!,
//                                       style: TextStyle(
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                           fontFamily: 'BeVietnamPro'),
//                                     ),
//                                     SizedBox(width: 8),
//                                     Container(
//                                       height: 24,
//                                       width: 24,
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: AssetImage(
//                                               'assets/images/Teklove/verify.png'),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 Container(
//                                   height: 36,
//                                   width: 36,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                           'assets/images/Teklove/eye.png'),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                               bottom: 38,
//                               left: 10,
//                               right: 10,
//                               child: Container(
//                                 height: 50,
//                                 width: double.maxFinite,
//                                 child: _buildInfor(infors: [
//                                   'Thích gặp mặt trực tiếp',
//                                   'Đang học đại học',
//                                   'Cung Song Ngư',
//                                   'Những hành động tinh tế'
//                                 ]),
//                               )),
//                         ],
//                       );