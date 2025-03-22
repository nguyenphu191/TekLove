import 'package:flutter/material.dart';

class SafetyCenterScreen extends StatefulWidget {
  @override
  _SafetyCenterScreenState createState() => _SafetyCenterScreenState();
}

class _SafetyCenterScreenState extends State<SafetyCenterScreen> {
  void _showPopup(String title, String content) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(16 * pix),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text("Xong"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80 * pix,
              width: size.width,
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Trung tâm an toàn',
                    style: TextStyle(
                      fontSize: 20 * pix,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'BeVietnamPro',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height - 80 * pix,
              width: size.width,
              color: Colors.white,
              child: ListView(
                children: [
                  _buildSectionTitle("An toàn"),
                  _buildListTile("Thông tin cơ bản",
                      "Những điều bạn cần biết để an toàn hơn trên Teklove và khi gặp gỡ ngoài đời..."),
                  _buildSectionTitle("Quấy rối"),
                  _buildListTile("Cách xử lý khi thấy chuyện gì đó không ổn",
                      "Nếu bạn cảm thấy không thoải mái, bạn có thể chặn và báo cáo thành viên đó."),
                  _buildSectionTitle("Gặp gỡ ngoài đời"),
                  _buildListTile("Hướng dẫn an toàn khi gặp gỡ ngoài đời",
                      "Luôn gặp ở nơi công cộng và thông báo cho bạn bè hoặc người thân về cuộc gặp."),
                  _buildSectionTitle("Báo cáo"),
                  _buildListTile("Khi nào nên hoặc không báo cáo",
                      "Bạn nên báo cáo nếu ai đó có hành vi xấu hoặc gây nguy hiểm."),
                  _buildListTile("Cách báo cáo một ai đó",
                      "Bạn có thể báo cáo ngay từ hồ sơ của họ hoặc trong cuộc trò chuyện."),
                  _buildListTile("Chuyện gì xảy ra sau khi bạn báo cáo",
                      "Chúng tôi sẽ xem xét báo cáo và có thể đưa ra biện pháp phù hợp."),
                  _buildSectionTitle("Đồng thuận"),
                  _buildListTile("Những điều cơ bản về đồng thuận",
                      "Sự đồng thuận là quan trọng trong mọi mối quan hệ. Hãy chắc chắn rằng cả hai bên đều đồng ý."),
                  _buildSectionTitle("Du lịch"),
                  _buildListTile("Điều lưu tâm khi thực hiện một chuyến đi",
                      "Hãy kiểm tra thông tin địa điểm và luôn giữ liên lạc với người thân."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String content) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return ListTile(
      title: Text(title,
          style: TextStyle(
              fontSize: 14 * pix,
              fontWeight: FontWeight.w300,
              fontFamily: 'BeVietnamPro')),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () => _showPopup(title, content),
    );
  }

  Widget _buildSectionTitle(String title) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      height: 50 * pix,
      width: size.width,
      padding: EdgeInsets.only(left: 16 * pix, top: 14 * pix),
      color: Colors.grey[200],
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16 * pix,
            fontWeight: FontWeight.bold,
            fontFamily: 'BeVietnamPro'),
      ),
    );
  }
}
