import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/statemange/network_managment.dart';
import '../widget/appbar.dart';
import 'main_screen.dart';


class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});
  static TextEditingController last_password = new TextEditingController();
  static TextEditingController new_password = new TextEditingController();
  static TextEditingController again_password = new TextEditingController();
  static String valid_text = "";
  @override
  Widget build(BuildContext context) {
    Get.put(NetworkManagment());
    return GetBuilder<NetworkManagment>(
      builder: (context) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color:Color.fromARGB(255, 252, 252, 252),
          child: Column(
            children: [
              AppBarWidget(AppBarText:'تغییر رمز عبور'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PasswordInput(hintText: 'رمز عبور قبلی...',controller: ChangePasswordScreen.last_password),
                    SizedBox(height: 15,),
                    PasswordInput(hintText: 'رمز عبور جدید...',controller: ChangePasswordScreen.new_password,),
                    SizedBox(height: 15,),
                    PasswordInput(hintText: 'تکرار رمز عبور...',controller: ChangePasswordScreen.again_password,),
                    SizedBox(height: 10,),
                    ChangePasswordScreen.valid_text != ''?Text((ChangePasswordScreen.valid_text == 'c'? '!تکرار رمز عبور اشتباه است':ChangePasswordScreen.valid_text == 'b'?'!رمز عبور اشتباه است':'!تغییر با موفقیت انجام شد'),style: TextStyle(color: (ChangePasswordScreen.valid_text == 'b' || ChangePasswordScreen.valid_text == 'c')? Colors.red:Colors.green,fontSize: 18),):SizedBox(),
                    SizedBox(height: 5,),
                    Text('حتما رمز عبور قوی انتخاب کنید',style: TextStyle(color: Colors.black,fontSize: 18),),
                    SizedBox(height: 15,),
                    GestureDetector(
                      onTap: () {
                        HomeScreen.homeNetwork.change_password();
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 13),
                        child: Text('تغییر رمز',style: TextStyle(color: Colors.white,fontSize: 21),),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const PasswordInput({
    super.key,
    required this.hintText,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 13),
      width: double.infinity,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: controller,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          style: TextStyle(fontSize: 21),
          decoration: InputDecoration.collapsed(
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(69, 0, 247, 255),
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}