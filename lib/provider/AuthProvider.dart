import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiklove_fe/models/Account.dart';
import 'package:tiklove_fe/pages/home/home.dart';
import 'package:tiklove_fe/provider/LoadingProvider.dart';
import 'package:tiklove_fe/start/start12.dart';
import 'package:tiklove_fe/start/start1_name.dart';
import 'package:tiklove_fe/utils.dart' as utils;
import 'package:http/http.dart' as http;

class DelayedFunction {
  static void delayedFunction(Function callback) {
    Future.delayed(Duration(seconds: 2), callback as FutureOr Function()?);
  }
}

class AuthProvider with ChangeNotifier {
  final String baseurl = utils.baseUrl;
  Account? _account;
  Account? get account => _account;

  Future<void> login(
      String phone, String password, BuildContext context) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.setLoading(true);
    final url = Uri.parse('$baseurl/account/login');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'phone': phone, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> account = jsonDecode(response.body)['account'];
        _account = Account.fromJson(account);
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login successfully'),
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if (response.statusCode == 201) {
        Map<String, dynamic> account = jsonDecode(response.body)['account'];
        _account = Account.fromJson(account);
        String message = jsonDecode(response.body)['message'];

        if (message == 'noprofile') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please complete your profile'),
          ));
          DelayedFunction.delayedFunction(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Start1Page()));
          });
        } else if (message == 'noimage') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please upload your image'),
          ));
          DelayedFunction.delayedFunction(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Start12Page()));
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Invalid phone or password'),
          ));
        }
      }
    } finally {
      loadingProvider.setLoading(false);
    }
    notifyListeners();
  }

  Future<void> register(
      String phone, String password, BuildContext context) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.setLoading(true);
    final url = Uri.parse('$baseurl/account/register');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'phone': phone, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> account = jsonDecode(response.body)['account'];
        _account = Account.fromJson(account);

        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Register successfully'),
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start1Page()));
      } else {
        throw Exception('Failed to register');
      }
    } finally {
      loadingProvider.setLoading(false);
    }
    notifyListeners();
  }

  Future<bool> logout() async {
    _account = null;
    notifyListeners();
    return true;
  }

  Future<Account> getAccount(String id) async {
    final url = Uri.parse('$baseurl/account/get/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Account.fromJson(data['account']);
    } else {
      throw Exception('Failed to load account');
    }
  }
}
