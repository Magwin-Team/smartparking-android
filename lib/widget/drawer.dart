import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/screen/change_password_screen.dart';
import 'package:weatherapp/screen/main_screen.dart';
import 'package:get/get.dart';
import '../screen/exit_qrcode.dart';
import '../statemange/change_screen.dart';

class DrawerWidget extends StatefulWidget {
  static var controller = Get.put(ScreenController());
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: RefreshIndicator(
          onRefresh: () async{
            await HomeScreen.homeNetwork.get_status_user();
            setState(() {});
          },
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    height: 80,
                    child: Image.asset('assets/img/car.png',)
                  ),
                  SizedBox(height: 7,),
                  Text(HomeScreen.fullname,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                  SizedBox(height: 15,),
                  PelakShowWidget(data: HomeScreen.car_tag),
                  SizedBox(height: 10,),
                  HomeScreen.status == ''?SizedBox():Text('شما در' + HomeScreen.status + ' هستید',style: TextStyle(color: Color.fromARGB(255, 0, 255, 76),fontSize:20),),
                  HomeScreen.status == ''?SizedBox():SizedBox(height: 10,),
                  HomeScreen.status == ''?SizedBox():GestureDetector(
                    onTap : ()async{
                      await HomeScreen.homeNetwork.get_status_user();
                      String imgLink = await HomeScreen.homeNetwork.get_exit_qrcode(HomeScreen.parking_id);
                      Get.to(ExitQrCode(imgLink: imgLink,));
                    },
                    child : Container(
                      padding : EdgeInsets.symmetric(vertical: 7,horizontal: 13),
                      child: Text('خروج از پارکینگ',style:TextStyle(color:Colors.white,fontSize:17)),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 17, 0),
                        borderRadius: BorderRadius.circular(10)
                      ),
                    )
                  ),
                  SizedBox(height: 10,),
                  ItemLine(),
                  ListMenuItem(index: 0,text: 'پارکینگ های اطراف من',icon: 'caricon'),
                  ItemLine(),
                  ListMenuItem(index: 1,text: 'تاریخچه',icon: 'history'),
                  ItemLine(),
                  ListMenuItem(index: 2,text: 'تاریخچه پرداخت',icon: 'cardhistory'),
                  ItemLine(),
                  ListMenuItem(index: 3,text: 'اطلاعات کاربری', icon: 'user'),
                  ItemLine(),
                  ListMenuItem(index: 4,text: 'تغییر رمز عبور', icon: 'lock'),
                  ItemLine(),
                  ListMenuItem(index: 5,text: 'خروج', icon: 'logout'),
                  ItemLine(),
                ],
              ),
             
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
          gradient: LinearGradient(colors: [Color.fromRGBO(34, 74, 190, 1),Color.fromRGBO(0, 219, 208, 1)],begin: Alignment.bottomLeft,end: Alignment.topRight)
        ),
      ),
    );
  }

  Container ItemLine() {
    return Container(
      width: double.infinity,
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      color: Color.fromARGB(143, 0, 0, 0),
    );
  }
}

class ListMenuItem extends StatelessWidget {
  final String text;
  final String icon;
  final int index;
  const ListMenuItem({
    super.key,
    required this.text,
    required this.icon,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () async{
            if(index == 5){
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('username','');
              await prefs.setString('password','');
              Restart.restartApp();
            }
            ChangePasswordScreen.valid_text = '';
            HomeScreen.screen_num = index;
            Scaffold.of(context).closeDrawer();
            DrawerWidget.controller.update_screen();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(this.text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
              SizedBox(width: 5,),
              Image.network('https://smartparking.iran.liara.run/static/asset/images/'+this.icon+'.png',height: 22,)
            ],
          ),
        );
      }
    );
  }
}



class PelakShowWidget extends StatelessWidget {
  final List<String> data;
  const PelakShowWidget({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:Colors.white,
        border:Border.all(color:Colors.black,width: 1,),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 35,
            child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9N0TSPVTbxzPBiTOrJQMoZfoAhkZi4fEI9Q&usqp=CAU'),
          ),
          Container(
            alignment: Alignment.center,
            width: 35,
            child: Text(data[0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
          ),
          Container(
            alignment: Alignment.center,
            child: Text(data[1],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(data[2],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
          ),
          Container(
            height: 35,
            width: 1,
            color: Colors.black,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(data[3],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
          ),
        ],
      ),
    );
  }
}