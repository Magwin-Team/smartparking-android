class HistoryModel{
  String parking_name;
  String login_time;
  String exit_time;
  String parking_image;
  int price;
  HistoryModel({
    required this.parking_name,
    required this.login_time,
    required this.exit_time,
    required this.parking_image,
    required this.price
  });
  static HistoryModel fromJson(Map<String,dynamic> data){
    return HistoryModel(
      parking_name: data['parking_name'], 
      login_time: data['login_time'], 
      exit_time: data['exit_time'], 
      parking_image: data['parking_img'], 
      price: data['price']
    );
  }
}