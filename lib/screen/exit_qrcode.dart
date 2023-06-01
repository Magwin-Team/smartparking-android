import 'package:flutter/material.dart';

class ExitQrCode extends StatelessWidget {
  final String imgLink;
  const ExitQrCode({super.key,required this.imgLink});

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
              this.imgLink == ''?Text('شما در پارکینگی نیستیند یا کد شما باطل شده است',style:TextStyle(color:Colors.red,fontSize:18)):Text('(اعتبار : 30 دقیقه) را در پارکینگ مد نظر اسکن کنید QrCode',style: TextStyle(fontSize: 15),),
            ],
          ),
        ),
      )
    );
  }
}