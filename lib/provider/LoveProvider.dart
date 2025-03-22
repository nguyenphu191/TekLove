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
  List<Love> _sendLove = [];
  List<Love> _receiveLove = [];
  Love? get love => _love;
  List<Love>? get sendLove => _sendLove;
  List<Love>? get recieverLove => _receiveLove;

  bool isLoading = false;

  void setLoad(bool load) {
    isLoading = load;
    notifyListeners();
  }

  Future<void> getLoveInfor(String myId, String candidateId) async {
    setLoad(true);
    try {
      final response =
          await http.get(Uri.parse('$baseurl/love/getLoveInfor/$myId'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String message = data['message'];

        if (message == 'success') {
          if (candidateId == data['candidateId']) {
            _love = Love.fromJson(data['love'] as Map<String, dynamic>);
          } else {
            _love = null;
          }
        } else if (message == 'pending') {
          _sendLove = (data['sendLove'] as List?)
                  ?.map((e) => Love.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [];

          _receiveLove = (data['receiveLove'] as List?)
                  ?.map((e) => Love.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [];
        }
        notifyListeners();
      } else {
        print("Lỗi API: Mã trạng thái ${response.statusCode}");
      }
    } catch (error) {
      print("Lỗi getLoveInfor: $error");
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
        if (!_sendLove
            .any((love) => love.receiver['accountId'] == candidateId)) {
          _sendLove.add(_love!);
          notifyListeners();
        }

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
          _sendLove = _sendLove
              .where((love) => !((love.receiver['accountId'] == candidateId &&
                      love.sender['accountId'] == myId) ||
                  (love.sender['accountId'] == candidateId &&
                      love.receiver['accountId'] == myId)))
              .toList();
          _receiveLove = _receiveLove
              .where((love) => !((love.receiver['accountId'] == candidateId &&
                      love.sender['accountId'] == myId) ||
                  (love.sender['accountId'] == candidateId &&
                      love.receiver['accountId'] == myId)))
              .toList();
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

        _receiveLove.clear();
        _sendLove.clear();
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
