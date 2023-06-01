import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/network/home_network.dart';
import 'package:weatherapp/screen/change_password_screen.dart';
import 'package:weatherapp/screen/parkings_screen.dart';
import 'package:weatherapp/statemange/change_screen.dart';
import 'package:weatherapp/widget/drawer.dart';
import 'package:get/get.dart';
import 'history_screen.dart';
import 'user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});
  static List screen_body = [ParkingScreen(),HistoryScreen(),UserInfo(),UserInfo(),ChangePasswordScreen()];
  static int screen_num = 0;
  static HomeNetwork homeNetwork = new HomeNetwork(username: '', password: '');
  static String fullname = "";
  static List<String> car_tag = ['','','',''];
  static String status = '';
  static int parking_id = -1;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static Future<void> getLocation() async {
    ParkingScreen.LocataionPermiss = await handleLocationPermission();
    print('permission is ok');
    if(ParkingScreen.LocataionPermiss){
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      HomeScreen.homeNetwork.get_parkings(position.latitude,position.longitude);
    }
  }
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) { 
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}

class _HomeScreenState extends State<HomeScreen> {


  
  @override
  Widget build(BuildContext context) {
    HomeScreen.getLocation();
    var controller = Get.put(ScreenController());
    return SafeArea(
      child: GetBuilder<ScreenController>(
        builder: (context) {
          print(HomeScreen.screen_body[HomeScreen.screen_num]);
          return Scaffold(
            drawer: DrawerWidget(),
            body: HomeScreen.screen_body[HomeScreen.screen_num]
          ,);
        }
      )
    );
  }
  
}



