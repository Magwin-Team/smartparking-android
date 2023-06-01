import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String AppBarText;
  const AppBarWidget({super.key,required this.AppBarText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: (){
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 3.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(colors: [Color.fromARGB(255, 0, 204, 255),Color.fromARGB(255, 0, 247, 255)],begin: Alignment.topRight,end: Alignment.bottomLeft)
                  ),
                  child: Icon(Icons.menu_rounded,size: 25,color: Colors.white,)
                ),
              );
            }
          ),
          Spacer(),
          Text(this.AppBarText,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}