import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/models/Love.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/provider/ProfileProvider.dart';
import 'package:tiklove_fe/utils.dart' as utils;
import 'package:http/http.dart' as http;

class LoveProvider with ChangeNotifier {
  final String baseurl = utils.baseUrl;
  Love? _love;
  String message = '';
  Love? get love => _love;

  bool isLoading = false;

  void setLoad(bool load) {
    isLoading = load;
    notifyListeners();
  }

  Future<void> checkLove(String myId, String candidateId) async {
    setLoad(true);
    _love = null;
    message = '';
    try {
      final response = await http.get(
        Uri.parse('$baseurl/love/check-love/$myId/$candidateId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['message'] == 'love' ||
            data['message'] == 'sent' ||
            data['message'] == 'received') {
          message = data['message'];
          _love = Love.fromJson(data['love'] as Map<String, dynamic>);
        } else {
          message = data['message'];
          _love = null;
        }
        notifyListeners();
      } else {
        print("Lỗi API: Mã trạng thái ${response.statusCode}");
      }
    } catch (error) {
      print("Lỗi checkLove: $error");
    } finally {
      setLoad(false);
    }
  }

  Future<bool> send(
      String myId, String candidateId, BuildContext context) async {
    setLoad(true);
    try {
      final response = await http.post(
        Uri.parse('$baseurl/love/send/$myId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'receiverId': candidateId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _love = Love.fromJson(data['love'] as Map<String, dynamic>);

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("Lỗi sendLove: $error");
      throw error;
    } finally {
      setLoad(false);
    }
  }

  Future<bool> cancel(
      String myId, String candidateId, BuildContext context) async {
    setLoad(true);
    try {
      final response = await http.post(
        Uri.parse('$baseurl/love/delete/$myId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'clientId': candidateId,
        }),
      );
      if (response.statusCode == 200) {
        _love = null;
        final data = jsonDecode(response.body);
        if (data['type'] == 'success') {
          Profile profile =
              Profile.fromJson(data['profileSender'] as Map<String, dynamic>);

          // Lấy ProfileProvider từ context để cập nhật đúng provider
          final profileProvider =
              Provider.of<ProfileProvider>(context, listen: false);
          profileProvider.setLove(profile);
        } else {
          print("Lỗi API cancel: ${data['message']}");
        }
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("Lỗi cancelLove: $error");
      throw error;
    } finally {
      setLoad(false);
    }
  }

  Future<bool> accept(
      String receiverId, String senderId, BuildContext context) async {
    setLoad(true);
    try {
      final response = await http.post(
        Uri.parse('$baseurl/love/accept'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'senderId': senderId,
          'receiverId': receiverId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey('love')) {
          _love = Love.fromJson(data['love'] as Map<String, dynamic>);
        }

        if (data.containsKey('profileReceiver')) {
          Profile profile =
              Profile.fromJson(data['profileReceiver'] as Map<String, dynamic>);

          // Lấy ProfileProvider từ context để cập nhật đúng provider
          final profileProvider =
              Provider.of<ProfileProvider>(context, listen: false);
          profileProvider.setLove(profile);
        }
        notifyListeners();
        return true;
      } else {
        print("Lỗi API accept: ${response.statusCode}");
        return false;
      }
    } catch (error) {
      print("Lỗi acceptLove: $error");
      return false;
    } finally {
      setLoad(false);
    }
  }
}
