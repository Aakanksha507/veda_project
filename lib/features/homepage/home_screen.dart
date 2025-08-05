import 'package:flutter/material.dart';
import 'package:myflutterapp/Api/api.dart';
import 'package:myflutterapp/features/auth/shared_preference.dart';
import 'package:myflutterapp/features/homepage/screens/message_screen.dart';
import 'package:myflutterapp/features/homepage/dashbaord_page.dart';
import 'package:myflutterapp/features/homepage/screens/setting_screen.dart';
import 'package:myflutterapp/models/user_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
//  final SharedPrefService _prefService = SharedPrefService();

//  List<User> _users =[];

 User? currentUser;

@override
void initState() {
  super.initState();
  loadCurrentUser();
}

Future<void> loadCurrentUser() async {
  final prefService = SharedPrefService();
  final user = await prefService.getCurrentUser();
  setState(() {
    currentUser = user;
  });
}


  //  @override
  // void initState() {
  //   super.initState();
  //   _loadUsers();
  // }

  // Future<void> _loadUsers() async {
  //   List<User> users = await _prefService.getAllUsers();
  //   setState(() {
  //     _users = users;
  //   });
  // }

  int selectedIndex = 0;

  void tapSelectedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    switch (selectedIndex) {
      case 0:
        screen =  ScreenPage();
        break;
      case 1:
        screen =  ApiDioPractice();
        break;
      case 2:
        screen =  MessageScreen();
        break;
      case 3:
        screen = SettingScreen();
        break;
      default:
        screen =  Center(child: Text('Unknown Screen'));
    }

    return Scaffold(

      // Bottom navigation bar

      body: screen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: tapSelectedItem,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor ,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}
