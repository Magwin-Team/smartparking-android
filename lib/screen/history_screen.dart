import 'package:flutter/material.dart';
import 'package:weatherapp/screen/main_screen.dart';
import '../widget/appbar.dart';
import '../statemange/network_managment.dart';
import '../models/history.dart';
import 'package:get/get.dart';
class HistoryScreen extends StatelessWidget {
  static List<HistoryModel> history_list = [];
  const HistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeScreen.homeNetwork.get_history();
    Get.put(NetworkManagment());
    return GetBuilder<NetworkManagment>(
      builder: (context) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color:Color.fromARGB(255, 252, 252, 252),
          child: Column(
            children: [
              AppBarWidget(AppBarText:'تاریخچه'),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context,index){
                    return HistoryCard(data: HistoryScreen.history_list[index]);
                  },
                  itemCount: HistoryScreen.history_list.length,
                )
              ,)
            ],
          ),
        );
      }
    );
  }
}

class HistoryCard extends StatelessWidget {
  final HistoryModel data;
  const HistoryCard({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 14,horizontal: 12),
      child: Row(
        children: [
          Image.network(data.parking_image,height: 70,),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(data.parking_name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
              SizedBox(height: 5,),
              Text('زمان ورود : '+ data.login_time,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text(data.exit_time,style: TextStyle(color: Color.fromARGB(255, 21, 253, 0),fontWeight: FontWeight.bold,fontSize: 16),),
                  Text(' : زمان خروج',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                ],
              ),
              SizedBox(height: 5,),
              Text('هزینه : '+data.price.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
            ],
          )
        ]
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color.fromARGB(255, 0, 204, 255),Color.fromARGB(255, 1, 176, 230)],begin: Alignment.topRight,end: Alignment.bottomLeft),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Color.fromARGB(96, 0, 0, 0),blurRadius: 10,spreadRadius: 0)]
      ),
    );
  }
}