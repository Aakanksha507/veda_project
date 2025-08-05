import 'dart:convert';
import 'package:myflutterapp/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  final String _usersKey = 'users';

  //to save data in a list
  Future<void> setData(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userList = prefs.getStringList(_usersKey) ?? [];

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

  //to retrive all data
  Future<List<User>> getAllUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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

}
