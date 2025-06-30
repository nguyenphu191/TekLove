import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:tiklove_fe/models/Profile.dart';
import 'package:tiklove_fe/utils.dart' as utils;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final String baseurl = utils.baseUrl;
  Profile? _profile;
  Profile? get profile => _profile;
  List<Profile> _otherprofiles = [];
  List<Profile> get profiles => _otherprofiles;

  void setLoaded(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setLove(Profile profile) {
    _profile = profile;
    notifyListeners();
  }

  Future<void> setProfile(String accountId, BuildContext context) async {
    final url = Uri.parse('$baseurl/profile/get/$accountId');
    setLoaded(true);
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('profile')) {
          Map<String, dynamic> profileData = responseData['profile'];
          _profile = Profile.fromJson(profileData);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to get profile');
      }
    } finally {
      setLoaded(false);
    }

    notifyListeners();
  }

  Future<Profile> getProfileById(String accountId, BuildContext context) async {
    final url = Uri.parse('$baseurl/profile/get/$accountId');
    setLoaded(true);
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('profile')) {
          Map<String, dynamic> profileData = responseData['profile'];
          return Profile.fromJson(profileData);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to get profile');
      }
    } finally {
      setLoaded(false);
    }
  }

  Future<void> getOtherProfiles(String accountId, BuildContext context) async {
    setLoaded(true);
    final url = Uri.parse('$baseurl/profile/getallprofile/$accountId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Đảm bảo rằng API trả về đúng key "profiles"
      if (responseData.containsKey('profiles')) {
        List<dynamic> profilesList = responseData['profiles'];
        _otherprofiles = profilesList.map((e) => Profile.fromJson(e)).toList();
        notifyListeners();
        setLoaded(false);
      } else {
        setLoaded(false);
        throw Exception('Invalid response format: Missing "profiles" key');
      }
    } else {
      setLoaded(false);
      throw Exception('Failed to get profiles');
    }
  }

  Future<void> getProfilesDiscovery(
      String accountId, String key, BuildContext context) async {
    setLoaded(true);
    final url = Uri.parse('$baseurl/profile/getdiscovery/$accountId');
    print(key);
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'key': key,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Đảm bảo rằng API trả về đúng key "profiles"
      if (responseData.containsKey('profiles')) {
        List<dynamic> profilesList = responseData['profiles'];
        _otherprofiles = profilesList.map((e) => Profile.fromJson(e)).toList();
        notifyListeners();
        setLoaded(false);
      } else {
        setLoaded(false);
        throw Exception('Invalid response format: Missing "profiles" key');
      }
    } else {
      setLoaded(false);
      throw Exception('Failed to get profiles');
    }
  }

  Future<void> createProfile(
    String accountId,
    String name,
    String gender,
    String genderlike,
    List<String> images,
    String birthday,
    String findfor,
    String sexuality,
    bool showSexInProfile,
    bool showGenderInProfile,
    int priorityDistance,
    String university,
    List<String> interests,
    Map<String, dynamic> habits,
    BuildContext context,
  ) async {
    setLoaded(true);
    final url = Uri.parse('$baseurl/profile/create/$accountId');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': name,
          'gender': gender,
          'genderlike': genderlike,
          'images': images,
          'birthday': birthday,
          'findfor': findfor,
          'sexuality': sexuality,
          'showSexInProfile': showSexInProfile,
          'showGenderInProfile': showGenderInProfile,
          'priorityDistance': priorityDistance,
          'university': university,
          'interests': interests,
          'habits': habits,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('profile')) {
          Map<String, dynamic> profileData = responseData['profile'];
          // print('Profile created: $profileData');
          _profile = Profile.fromJson(profileData);
          notifyListeners();
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to create profile');
      }
    } finally {
      setLoaded(false);
    }
  }

  Future<bool> uploadImages(
      BuildContext context, String accountId, List<XFile> _images) async {
    var uri = Uri.parse('$baseurl/profile/upload-image/$accountId');
    setLoaded(true);

    // Tạo một MultipartRequest duy nhất
    var request = http.MultipartRequest('POST', uri);

    // Gửi thêm dữ liệu dạng text
    request.fields['accountId'] = accountId;

    // Thêm tất cả ảnh vào request
    for (var image in _images) {
      var mimeType = lookupMimeType(image.path) ?? 'image/jpeg';
      var imageFile = await http.MultipartFile.fromPath(
        'files', // Sử dụng key 'files' để gửi nhiều ảnh
        image.path,
        contentType: MediaType.parse(mimeType),
      );
      request.files.add(imageFile);
    }

    // http.MultipartRequest tự set Content-Type nên không cần set lại thủ công
    // request.headers['Content-Type'] = 'multipart/form-data';

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    var jsonResponse = json.decode(responseBody);

    setLoaded(false);

    if (response.statusCode == 200) {
      // Cập nhật profile nếu cần
      _profile = Profile.fromJson(jsonResponse['profile']);
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload thành công')),
      );
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteImage(
      BuildContext context, String accountId, String imageUrl) async {
    var uri = Uri.parse('$baseurl/profile/delete-image/$accountId');
    setLoaded(true);
    print('Gửi request xóa ảnh: $imageUrl');
    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'imageUrl': imageUrl,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('profile')) {
          Map<String, dynamic> profileData = responseData['profile'];
          _profile = Profile.fromJson(profileData);
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Xóa ảnh thành công')),
          );
        } else {
          print("Lỗi: Response không chứa 'profile'");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xóa ảnh thất bại')),
        );
        print("Lỗi: Status code không phải 200");
      }
    } catch (e) {
      print("Lỗi khi gửi request: $e");
    } finally {
      setLoaded(false);
    }
  }

  Future<bool> updateProfile(
      String accountId, Map<String, dynamic> updatedData) async {
    setLoaded(true);
    try {
      // print("Gửi request đến: $baseurl/profile/update/$accountId");
      // print("Dữ liệu gửi đi: ${jsonEncode(updatedData)}");

      final response = await http.patch(
        Uri.parse('$baseurl/profile/update/$accountId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('profile')) {
          Map<String, dynamic> profileData = responseData['profile'];
          _profile = Profile.fromJson(profileData);
          notifyListeners();
          return true;
        } else {
          print("Lỗi: Response không chứa 'profile'");
        }
      } else {
        print("Lỗi: Status code không phải 200");
      }
    } catch (e) {
      print("Lỗi khi gửi request: $e");
    } finally {
      setLoaded(false); // Đảm bảo luôn tắt loading
    }

    return false;
  }

  Future<void> likeProfile(
      String accountId, String profileId, BuildContext context) async {
    setLoaded(true);
    try {
      final response = await http.post(
        Uri.parse('$baseurl/profile/like/$accountId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'profileId': profileId,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('profile')) {
          Map<String, dynamic> profileData = responseData['profile'];
          _profile = Profile.fromJson(profileData);
          _otherprofiles
              .removeWhere((element) => element.accountId == profileId);
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Like profile'),
          ));
        } else {
          print("Lỗi: Response không chứa 'profile'");
        }
      } else if (response.statusCode == 400) {
        String message = jsonDecode(response.body)['message'];
        if (message == 'Out of likes') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Hết lượt like'),
          ));
        }
      }
    } catch (e) {
      print("Lỗi khi gửi request: $e");
    } finally {
      setLoaded(false); // Đảm bảo luôn tắt loading
    }
  }

  Future<void> superLikeProfile(
      String accountId, String profileId, BuildContext context) async {
    setLoaded(true);
    try {
      final response = await http.post(
        Uri.parse('$baseurl/profile/superlike/$accountId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'profileId': profileId,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('profile')) {
          Map<String, dynamic> profileData = responseData['profile'];
          _profile = Profile.fromJson(profileData);
          _otherprofiles
              .removeWhere((element) => element.accountId == profileId);
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Superlike profile'),
          ));
        } else {
          print("Lỗi: Response không chứa 'profile'");
        }
      } else if (response.statusCode == 400) {
        String message = jsonDecode(response.body)['message'];
        if (message == 'Out of superlikes') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Hết lượt superlike'),
          ));
        }
      } else {
        print("Lỗi: Status code không phải 200");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Lỗi superlike profile'),
        ));
      }
    } catch (e) {
      print("Lỗi khi gửi request: $e");
    } finally {
      setLoaded(false); // Đảm bảo luôn tắt loading
    }
  }

  Future<void> skipProfile(
      String accountId, String profileId, BuildContext context) async {
    setLoaded(true);
    try {
      final response = await http.post(
        Uri.parse('$baseurl/profile/skip/$accountId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'profileId': profileId,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('profile')) {
          Map<String, dynamic> profileData = responseData['profile'];
          _profile = Profile.fromJson(profileData);
          _otherprofiles
              .removeWhere((element) => element.accountId == profileId);
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Bỏ qua profile'),
          ));
        } else {
          print("Lỗi: Response không chứa 'profile'");
        }
      } else {
        print("Lỗi: Status code không phải 200");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Lỗi bỏ qua profile'),
        ));
      }
    } catch (e) {
      print("Lỗi khi gửi request: $e");
    } finally {
      setLoaded(false); // Đảm bảo luôn tắt loading
    }
  }

  Future<List<Map<String, dynamic>>> getMatch(
      String accountId, BuildContext context) async {
    setLoaded(true);
    final url = Uri.parse('$baseurl/profile/getmatch/$accountId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        // Kiểm tra key chính xác từ API
        if (responseBody.containsKey('match')) {
          final List<dynamic> profilesData = responseBody['match'];

          // Chuyển đổi dữ liệu thành danh sách Map<String, dynamic>
          return profilesData
              .map((data) => Map<String, dynamic>.from(data))
              .toList();
        } else {
          debugPrint("Lỗi: Response không chứa 'match'");
          return [];
        }
      } else {
        debugPrint("Lỗi: Status code không phải 200 (${response.statusCode})");
        return [];
      }
    } catch (e) {
      debugPrint("Lỗi khi gửi request: $e");
      return [];
    } finally {
      setLoaded(
          false); // Đảm bảo cập nhật trạng thái sau khi request hoàn thành
    }
  }
}
