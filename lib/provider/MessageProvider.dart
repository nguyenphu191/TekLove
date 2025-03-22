import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:tiklove_fe/models/message.dart';
import 'package:http_parser/http_parser.dart';
import 'package:tiklove_fe/utils.dart' as utils;
import 'package:http/http.dart' as http;

class MessageProvider with ChangeNotifier {
  final String baseurl = utils.baseUrl;
  List<Message> _messages = [];
  List<Message> _allMessages = [];
  bool isLoading = false;
  List<Message> getMessages() {
    return _messages;
  }

  List<Message> getAllMessages() {
    return _allMessages;
  }

  void setLoad(bool load) {
    isLoading = load;
    notifyListeners();
  }

  Future<void> fetchMessages(String myId, String candidateId) async {
    setLoad(true);
    try {
      final response = await http.post(
        Uri.parse('$baseurl/message/get/$myId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'clientId': candidateId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _messages = (data['data'] as List<dynamic>)
            .map((json) => Message.fromJson(json as Map<String, dynamic>))
            .toList();
        notifyListeners();
      } else {
        print("API không trả về status 200");
      }
    } catch (error) {
      print("Lỗi fetchMessages: $error");
      throw error;
    } finally {
      setLoad(false);
    }
  }

  Future<void> fetchAllMessages(String myId) async {
    setLoad(true);
    try {
      final response = await http.get(
        Uri.parse('$baseurl/message/getall/$myId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dynamic messagesData = data['data'];

        if (messagesData is List) {
          // Nếu là danh sách, parse bình thường
          _allMessages = messagesData
              .map<Message>((conversation) => Message.fromJson(
                  conversation['lastMessage'] as Map<String, dynamic>))
              .toList();
        } else if (messagesData is Map) {
          // Nếu chỉ có 1 tin nhắn, đặt vào danh sách
          _allMessages = [
            Message.fromJson(messagesData as Map<String, dynamic>)
          ];
        }

        notifyListeners();
      }
    } catch (error) {
      print("Lỗi fetchAllMessages: $error");
      throw error;
    } finally {
      setLoad(false);
    }
  }

  /// Hàm gửi tin nhắn (có thể gửi kèm danh sách ảnh)
  Future<bool> sendMessage({
    required String senderId,
    required String receiverId,
    required String content,
    List<XFile>? images,
  }) async {
    setLoad(true);
    try {
      // Tạo URL với senderId được truyền qua params
      var uri = Uri.parse('$baseurl/message/send/$senderId');
      var request = http.MultipartRequest('POST', uri);

      // Gửi thông tin text
      request.fields['receiverId'] = receiverId;
      request.fields['content'] = content;

      // Nếu có ảnh thì thêm vào request (key 'files' phải khớp với cấu hình backend)
      if (images != null && images.isNotEmpty) {
        for (var image in images) {
          var mimeType = lookupMimeType(image.path) ?? 'image/jpeg';
          var multipartFile = await http.MultipartFile.fromPath(
            'files', // Key này phải trùng với key mà backend mong đợi
            image.path,
            contentType: MediaType.parse(mimeType),
          );
          request.files.add(multipartFile);
        }
      }

      // Gửi request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        // Giả sử API trả về tin nhắn mới trong key 'data'
        Message newMessage = Message.fromJson(data['data']);

        // Cập nhật danh sách tin nhắn (nếu cần)
        _messages.add(newMessage);
        notifyListeners();
        return true;
      } else {
        print("Lỗi gửi tin nhắn: ${response.statusCode}");
        return false;
      }
    } catch (error) {
      print("Error sending message: $error");
      return false;
    } finally {
      setLoad(false);
    }
  }
}
