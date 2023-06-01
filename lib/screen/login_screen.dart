import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static bool login_accept = false;
  static TextEditingController username_controller = new TextEditingController();
  static TextEditingController password_controller = new TextEditingController();
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width:double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('ورود',style: TextStyle(fontSize:28),),
              SizedBox(height:20),
              username_input(LoginScreen.username_controller),
              SizedBox(height:20),
              password_input(LoginScreen.password_controller),
              SizedBox(height:10),
              LoginScreen.login_accept == true?Text('اطلاعات وارد شده اشتباه است',style:TextStyle(color:Colors.red,fontSize:17)):SizedBox(),
              SizedBox(height:20),
              GestureDetector(
                onTap:()async{
                  bool res = await HomeScreen.homeNetwork.login(LoginScreen.username_controller.text, LoginScreen.password_controller.text);
                  if(res){
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('username',LoginScreen.username_controller.text);
                    await prefs.setString('password',LoginScreen.password_controller.text);
                    Restart.restartApp();
                  }else{
                    LoginScreen.login_accept = true;
                    setState((){});
                  }
                  
                },
                child:Container(
                  child:Text('ثبت',style:TextStyle(color: Colors.white,fontSize:22)),
                  padding:EdgeInsets.symmetric(vertical: 5,horizontal:40),
                  decoration: BoxDecoration(
                    color:Color.fromARGB(255, 0, 204, 255),
                    borderRadius: BorderRadius.circular(20)
                  ),
                )
              ),
              SizedBox(height:20),
              GestureDetector(
                onTap :() {
                  _launchUrl('https://smartparking.iran.liara.run/signin');
                },
                child: Text('آیا حساب کاربری ندارید؟ساخت حساب کاربری',style:TextStyle(fontSize:17,decoration: TextDecoration.underline)))
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _launchUrl(String url_o) async {
    if (!await launchUrl(Uri.parse(url_o))) {
      throw Exception(Uri.parse(url_o));
    }
  }
  Widget username_input(TextEditingController controller){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 13),
      width: double.infinity,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: controller,
          style: TextStyle(fontSize: 21),
          decoration: InputDecoration.collapsed(
            hintText: 'نام کاربری...',
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
  Widget password_input(TextEditingController controller){
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
            hintText: 'رمز عبور...',
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
