import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../widget/appbar.dart';
import '../models/parking.dart';
import '../statemange/network_managment.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login_qrcode.dart';
import 'main_screen.dart';
class ParkingScreen extends StatefulWidget {
  static List<ParkingModel> parkingModelkingList = [];
  static bool LocataionPermiss = false;
  const ParkingScreen({
    super.key,
  });

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  
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
              AppBarWidget(AppBarText:'پارکینگ هوشمند'),
              ParkingScreen.LocataionPermiss==false
              ? Expanded(
                child: RefreshIndicator(onRefresh: ()async{
                  await HomeScreen.getLocation();
                  setState(() {});
                },child: ListView(
                  children: [
                    Text('دسترسی به موقعیت مکانی داده نشده یا موقعیت مکانی خاموش است',style:TextStyle(fontSize:18),textAlign: TextAlign.center,),
                  ],
                )),
              )
              : Expanded(
                child: RefreshIndicator(
                  onRefresh: ()async{
                    await HomeScreen.getLocation();
                  },
                  child: ListView.builder(
                    itemBuilder: (BuildContext context,index){
                      return ParkingCard(data: ParkingScreen.parkingModelkingList[index]);
                    },
                    itemCount: ParkingScreen.parkingModelkingList.length,
                  ),
                )
              ,)
            ],
          ),
        );
      }
    );
  }
}


class ParkingCard extends StatelessWidget {
  final ParkingModel data;
  const ParkingCard({
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.distance.toString()+' km : فاصله',style: TextStyle(fontSize: 15,color: Colors.white),),
              SizedBox(height: 5,),
              Text(data.parking_capcity.toString()+'/'+data.parking_capcity_full.toString()+' : ظرفیت',style: TextStyle(fontSize: 15,color: Colors.white),),
              SizedBox(height: 5,),
              Row(
                children: [
                  GestureDetector(
                    onTap : () async{
                      String imgLink =  await HomeScreen.homeNetwork.get_login_qrcode(data.parking_id);
                      Get.to(LoginQrcode(imgLink: imgLink,));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14,vertical: 5),
                      child: Text('درخواست ورود',style: TextStyle(color: Colors.white,fontSize: 13),),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 183, 65, 0.95),
                        borderRadius: BorderRadius.circular(7)
                      ),
                    ),
                  ),
                  SizedBox(width: 7,),
                  GestureDetector(
                    onTap : (){
                      _launchUrl(data.router_link);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14,vertical: 5),
                      child: Text('مسیریابی',style: TextStyle(color: Colors.white,fontSize: 13),),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 141, 0, 1),
                        borderRadius: BorderRadius.circular(7)
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text(data.parking_name_fa,style: TextStyle(fontSize: 15,color: Colors.white),),
              SizedBox(height: 6,),
              Text(data.parking_name_en,style: TextStyle(fontSize: 15,color: Colors.white),),
              SizedBox(height: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:4),
                    child: Text(data.parking_like.toString(),style: TextStyle(fontSize: 15,color: Colors.white),),
                  ),
                  Icon(Icons.star_rounded,color: Color.fromRGBO(255, 235, 59, 1),size: 15,)
                ],
              )
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color.fromARGB(255, 0, 204, 255),Color.fromARGB(255, 1, 176, 230)],begin: Alignment.topRight,end: Alignment.bottomLeft),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Color.fromARGB(96, 0, 0, 0),blurRadius: 10,spreadRadius: 0)]
      ),
    );
  }
  Future<void> _launchUrl(String url_o) async {
    if (!await launchUrl(Uri.parse(url_o))) {
      throw Exception(Uri.parse(url_o));
    }
  }
}
