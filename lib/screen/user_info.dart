import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/screen/main_screen.dart';
import '../statemange/network_managment.dart';
import '../widget/appbar.dart';
import '../widget/drawer.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});
  static String name = '';
  static String family = '';
  static String number = '';
  static String email = '';
  static String n_code = '';
  static String birth_date = '';
  static List<String> pelak = [];
  @override
  Widget build(BuildContext context) {
    HomeScreen.homeNetwork.get_info();
    Get.put(NetworkManagment());
    return GetBuilder<NetworkManagment>(
      builder: (context) {
        return UserInfo.name != ''? Container(
          width: double.infinity,
          height: double.infinity,
          color:Color.fromARGB(255, 252, 252, 252),
          child: Column(
            children: [
              AppBarWidget(AppBarText:'اطلاعات کاربری'),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('نام : '+UserInfo.name,style: TextStyle(fontSize: 18),),
                          SizedBox(height: 10,),
                          Text('نام خانوادگی : '+UserInfo.family,style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      color: Color.fromARGB(143, 0, 0, 0),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(UserInfo.number +' : شماره همراه',style: TextStyle(fontSize: 18),),
                          SizedBox(height: 10,),
                          Text(UserInfo.email +' : ایمیل',style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      color: Color.fromARGB(143, 0, 0, 0),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(UserInfo.n_code+' : کد ملی',style: TextStyle(fontSize: 18),),
                          SizedBox(height: 10,),
                          Text(UserInfo.birth_date+' : تاریخ تولد',style: TextStyle(fontSize: 18),)
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      color: Color.fromARGB(143, 0, 0, 0),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(': پلاک',style: TextStyle(fontSize: 18),),
                          SizedBox(height: 10,),
                          PelakShowWidget(data: UserInfo.pelak,)
                        ],
                      ),
                    ),
                  ],
                )
              ,)
            ],
          ),
        ):SizedBox();
      }
    );
  }
}