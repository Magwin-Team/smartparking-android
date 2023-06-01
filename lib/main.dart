import 'package:flutter/material.dart';
import 'screen/login_screen.dart';
import 'screen/main_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network/home_network.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');
  if(username != null && username != ''){
    HomeScreen.homeNetwork = new HomeNetwork(username: username,password: prefs.getString('password')!);
    MyApp.autoLogin = true;
    await HomeScreen.homeNetwork.get_status_user();
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static bool autoLogin = false;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'iransans'),
      home: MyApp.autoLogin?HomeScreen() : LoginScreen()
    );
  }
}