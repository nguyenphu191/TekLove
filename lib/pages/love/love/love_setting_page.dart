import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoveSettingsPage extends StatefulWidget {
  @override
  _LoveSettingsPageState createState() => _LoveSettingsPageState();
}

class _LoveSettingsPageState extends State<LoveSettingsPage> {
  DateTime _selectedDate = DateTime.now();
  bool _showTitle = true;
  String _title = "Bên nhau";
  Color _selectedColor = Colors.black;
  final List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.white,
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedDate = DateTime.parse(
          prefs.getString('start_date') ?? DateTime.now().toString());
      _showTitle = prefs.getBool('show_title') ?? true;
      _title = prefs.getString('title') ?? "Bên nhau";
      _selectedColor = colors[prefs.getInt('title_color') ?? 0];
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('start_date', _selectedDate.toIso8601String());
    await prefs.setBool('show_title', _showTitle);
    await prefs.setString('title', _title);
    await prefs.setInt('title_color', colors.indexOf(_selectedColor));
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _saveSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80 * pix,
            width: size.width,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16 * pix),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 10 * pix),
                Text(
                  "Cài đặt",
                  style: TextStyle(
                    fontSize: 18 * pix,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BeVietnamPro',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16 * pix),
            child: ListTile(
              title: Text("Ngày bắt đầu"),
              subtitle: Text("${_selectedDate.toLocal()}".split(' ')[0]),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16 * pix),
            child: SwitchListTile(
              title: Text("Đăng tiêu đề trên trang"),
              value: _showTitle,
              onChanged: (bool value) {
                setState(() {
                  _showTitle = value;
                });
                _saveSettings();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16 * pix),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Tiêu đề",
              ),
              onChanged: (value) {
                setState(() {
                  _title = value;
                });
                _saveSettings();
              },
              controller: TextEditingController(text: _title),
            ),
          ),
          Container(
              padding: EdgeInsets.all(16 * pix),
              child: Text("Chọn màu chữ:", style: TextStyle(fontSize: 16))),
          Container(
            padding: EdgeInsets.all(16 * pix),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: colors.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                    _saveSettings();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color.fromARGB(255, 128, 128, 128),
                          width: _selectedColor == color ? 3 : 1),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
