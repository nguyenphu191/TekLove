import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, String>> nots = [
    {
      'title': 'Thông báo 1',
      'content': 'Nội dung thông báo 1',
      'image': 'assets/images/Teklove/eye.png',
    },
    {
      'title': 'Thông báo 2',
      'content': 'Nội dung thông báo 2',
      'image': 'assets/images/Teklove/eye.png',
    },
    {
      'title': 'Thông báo 3',
      'content': 'Nội dung thông báo 3',
    },
    {
      'title': 'Thông báo 4',
      'content': 'Nội dung thông báo 4',
      'image': 'assets/images/Teklove/eye.png',
    },
    {
      'title': 'Thông báo 5',
      'content': 'Nội dung thông báo 5',
      'image': 'assets/images/Teklove/eye.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 64,
            width: size.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Row(
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
                SizedBox(width: 10),
                Container(
                  height: 64,
                  width: size.width - 100,
                  child: Text(
                    'Thông báo',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: nots.length,
              itemBuilder: (context, index) {
                return _noti(nots[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _noti(Map<String, String> not) {
    return Column(
      children: [
        Divider(
          height: 2,
        ),
        Container(
          height: 116,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Row(
            children: [
              not['image'] != null
                  ? Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(not['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.notifications,
                      size: 50,
                    ),
              SizedBox(width: 10),
              Container(
                height: 86,
                width: 290,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      not['title']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      not['content']!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontFamily: 'BeVietnamPro',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, '/login');
                      },
                      child: Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.blue,
                          ),
                        ),
                        child: Text(
                          'Xem',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            fontFamily: 'BeVietnamPro',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 0, 0),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
