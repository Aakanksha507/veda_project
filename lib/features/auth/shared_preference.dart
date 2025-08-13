import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:myflutterapp/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  final String _usersKey = 'users';

  //to save data in a list
  Future<void> setData(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userList = prefs.getStringList(_usersKey) ?? [];
    // debugPrint("%%%%% usersdata: ${userList}");

    userList.removeWhere((jsonStr) {
      final map = jsonDecode(jsonStr);
      return map['phoneNumber'] == user.phoneNumber;
    });

    userList.add(jsonEncode(user.toJson()));
    await prefs.setStringList(_usersKey, userList);
  }

  // if user is alreday login
  Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final phoneNumber = prefs.getString('phoneNumber');
    return phoneNumber != null && phoneNumber.isNotEmpty;
  }

  // to get logout
  Future<void> clearData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('phoneNumber');
  }


Future<List<User>> getAllUsers() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
// print("Saved phone number: ${prefs.getString('phoneNumber')}");
// print("Saved users: ${prefs.getStringList('users')}");

  List<String> userList = prefs.getStringList(_usersKey) ?? [];
  return userList.map((userJson) {
    Map<String, dynamic> userMap = jsonDecode(userJson);
    return User.fromJson(userMap);
  }).toList();
}

  //to remove user according to phone number

  Future<void> removeUser(String phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> usersList = prefs.getStringList(_usersKey) ?? [];

    usersList.removeWhere((userJson) {
      final userMap = jsonDecode(userJson);
      return userMap['phoneNumber'] == phoneNumber;
    });

    await prefs.setStringList(_usersKey, usersList);
  }

  Future<void> setUserPhoneNumber(String phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber);
  }

  Future<String?> getUserPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber');
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final phoneNumber = prefs.getString('phoneNumber');
    if (phoneNumber == null) return null;

    final users = await getAllUsers();
    return users.firstWhere((user) => user.phoneNumber == phoneNumber);
  }

  Future<void> saveImageToPrefs(File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final phoneNumber = prefs.getString('phoneNumber');
    if (phoneNumber == null) return;

    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    List<String> userList =
        prefs.getStringList(_usersKey) ?? []; // get all user
    // update image of that cartain user
    List<String> updatedUserList =
        userList.map((userJson) {
          final userMap = jsonDecode(userJson);
          if (userMap['phoneNumber'] == phoneNumber) {
            userMap['profileImg'] = base64Image;
          }
          return jsonEncode(userMap);
        }).toList();
    await prefs.setStringList(_usersKey, updatedUserList);
  }

  Future<File?> loadUserProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final phoneNumber = prefs.getString('phoneNumber');
    if (phoneNumber == null) return null;

    List<String> userList = prefs.getStringList(_usersKey) ?? [];

    for (var userJson in userList) {
      final userMap = jsonDecode(userJson);
      if (userMap['phoneNumber'] == phoneNumber) {
        final base64Image = userMap['profileImg'];
                // print("Match User Phone: ${base64Image}");
        if (base64Image != null && base64Image.isNotEmpty) {
          final bytes = base64Decode(base64Image);
          final appDocDir = await getApplicationDocumentsDirectory();
          final file = File('${appDocDir.path}/profile_img_${DateTime.now().millisecondsSinceEpoch}');
          debugPrint("&&&& Image: '${appDocDir.path}/profile_img_${DateTime.now().millisecondsSinceEpoch}'");
          await file.writeAsBytes(bytes, flush: true);
          return file;
        }
      }
    }
    return null;
  }

  Future<void> clearUserProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final phoneNumber = prefs.getString('phoneNumber');
    if (phoneNumber == null) return;

    List<String> userList = prefs.getStringList(_usersKey) ?? [];

    List<String> updated =
        userList.map((userJson) {
          final userMap = jsonDecode(userJson);
          if (userMap['phoneNumber'] == phoneNumber) {
            userMap.remove('profileImg');
          }
          return jsonEncode(userMap);
        }).toList();
        // debugPrint("%%& userlist: ${updated}");
        

    await prefs.setStringList(_usersKey, updated);
  }

}
