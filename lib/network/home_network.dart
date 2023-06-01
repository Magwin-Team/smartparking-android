import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/screen/main_screen.dart';
import '../screen/history_screen.dart';
import 'package:weatherapp/screen/user_info.dart';
import '../models/history.dart';
import '../statemange/network_managment.dart';
import './network.dart';
import 'package:http/http.dart' as http;
import '../models/parking.dart';
import '../screen/parkings_screen.dart';
import '../screen/change_password_screen.dart';
class HomeNetwork extends Network{
  String username;
  String password;
  HomeNetwork({required this.username,required this.password});

  Future<void> get_parkings(double lat,double lon) async {
    var request = http.Request('GET',Uri.parse(url+getparking));
    request.body = json.encode(
      {
        'lat' : lat,
        'lon' : lon
      }
    );
    request.headers.addAll(headers);
    var response_enc = await request.send();
    var response = json.decode(await response_enc.stream.bytesToString());
    List parking_list = response['data'];
    ParkingScreen.parkingModelkingList.clear();
    parking_list.forEach((element) {
      ParkingScreen.parkingModelkingList.add(ParkingModel.fromJson(element));
    });
    var controller = Get.put(NetworkManagment());
    controller.load_data();
  }

  Future<void> get_history() async{
    var request = http.Request('GET', Uri.parse(url+history));
    request.body = json.encode(
      {
        "username" : username,
        "password" : password
      }
    );
    request.headers.addAll(headers);
    var response = await request.send();
    List list_history = json.decode(await response.stream.bytesToString())['data'];
    HistoryScreen.history_list.clear();
    list_history.forEach((element) {
      HistoryScreen.history_list.add(HistoryModel.fromJson(element));
    });
    var controller = Get.put(NetworkManagment());
    controller.load_data();
  }

  Future<void> get_info() async{
    var request = http.Request('GET', Uri.parse(url+infouser));
    request.body = json.encode(
      {
        'username' : username,
        'password' : password
      }
    );
    request.headers.addAll(headers);
    var response = await request.send();
    var data = json.decode(await response.stream.bytesToString());
    UserInfo.name = data['firstname'];
    UserInfo.family = data['lastname'];
    UserInfo.number = data['tel_number'];
    UserInfo.email = data['email'];
    UserInfo.n_code = data['national_code'];
    UserInfo.birth_date = data['date_of_birth'];
    UserInfo.pelak = [data['car_tag_1'].toString(),data['car_tag_2'],data['car_tag_3'].toString(),data['car_tag_4'].toString()];
    var controller = Get.put(NetworkManagment());
    controller.load_data();
  }
  Future<void> change_password() async{
    String last_password = ChangePasswordScreen.last_password.text;
    String new_password = ChangePasswordScreen.new_password.text;
    String again_password = ChangePasswordScreen.again_password.text;
    if(new_password == again_password){
      var request = http.Request('GET',Uri.parse(url+changepassword));
      request.body = json.encode(
        {
          'username' : username,
          'password' : last_password,
          'new-password' : new_password
        }
      );
      request.headers.addAll(headers);
      var response = await request.send();
      var status = json.decode(await response.stream.bytesToString())['status'];
      if(status == true){
        ChangePasswordScreen.valid_text = 'a';
        password = new_password;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('password', new_password);
      }else{
        ChangePasswordScreen.valid_text = 'b';
      }
    }else{
      ChangePasswordScreen.valid_text = 'c';
    }
    var controller = Get.put(NetworkManagment());
    controller.load_data();
  }

  Future<void> get_status_user() async{
    var request = http.Request('GET',Uri.parse(url+status_user));
    request.body = json.encode(
      {
        'username' : username,
        'password' : password
      }
    );
    request.headers.addAll(headers);
    var response = await request.send();
    var data = json.decode(await response.stream.bytesToString());
    print(data);
    HomeScreen.fullname = data['name'];
    HomeScreen.car_tag = [data['car_1'],data['car_2'],data['car_3'],data['car_4']];
    HomeScreen.status = data['status'];
    HomeScreen.parking_id = data['parking-id'];
  }


  Future<String> get_login_qrcode(int parking_id) async{
    var request = http.Request('GET',Uri.parse(url+login_qrcode));
    request.body = json.encode(
      {
        'username' : username,
        'password' : password,
        'parking-id' : parking_id
      }
    );
    request.headers.addAll(headers);
    var response = await request.send();
    var data = json.decode(await response.stream.bytesToString());
    return data['qrcode-link'];
  }
  Future<String> get_exit_qrcode(int parking_id) async{
    var request = http.Request('GET',Uri.parse(url+exit_qrcode));
    request.body = json.encode(
      {
        'username' : username,
        'password' : password,
        'parking-id' : parking_id
      }
    );
    request.headers.addAll(headers);
    var response = await request.send();
    var data = json.decode(await response.stream.bytesToString());
    return data['qrcode-link'];
  }
  Future<void> remove_qr_code() async{
    var request = http.Request('GET',Uri.parse(url+remove_qrcode));
    request.body = json.encode(
      {
        'username' : username,
        'password' : password
      }
    );
    request.headers.addAll(headers);
    await request.send();
  }

  Future<bool> login(String _username,String _password) async{
    var request = http.Request('GET',Uri.parse(url+'login'));
    request.body = json.encode(
      {
        'username' : _username,
        'password' : _password
      }
    );
    request.headers.addAll(headers);
    var response = await request.send();
    return json.decode(await response.stream.bytesToString())['status'] ;
  }

}