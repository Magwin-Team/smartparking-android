import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/network/home_network.dart';

import 'main_screen.dart';

class LoginQrcode extends StatelessWidget {
  final String imgLink;
  const LoginQrcode({super.key,required this.imgLink});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              this.imgLink == ''?SizedBox():Image.network(this.imgLink,height: 150,),
              this.imgLink == ''?SizedBox():SizedBox(height: 10,),
              this.imgLink == ''?Text('شما کد پارکینگ دیگری را دارید یا در آن هستید',style:TextStyle(color:Colors.red,fontSize:18)):Text('را در پارکینگ مد نظر اسکن کنید QrCode',style: TextStyle(fontSize: 20),),
              this.imgLink == ''?SizedBox():SizedBox(height: 10,),
              this.imgLink == ''?SizedBox():GestureDetector(
                onTap: ()async{
                  await HomeScreen.homeNetwork.remove_qr_code();
                  Get.back();
                },
                child: Container(
                  child: Text('QrCode حذف',style: TextStyle(color: Colors.white,fontSize:16),),
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  decoration: BoxDecoration(
                    color:Colors.red,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}