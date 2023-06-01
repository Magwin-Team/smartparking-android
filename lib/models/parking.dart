class ParkingModel{
  int parking_id;
  String parking_name_fa;
  String parking_name_en;
  String distance;
  String parking_image;
  String router_link;
  int parking_like;
  int parking_capcity;
  int parking_capcity_full;
  
  ParkingModel({
    required this.parking_id,
    required this.parking_name_fa,
    required this.parking_name_en,
    required this.parking_like,
    required this.parking_image,
    required this.parking_capcity,
    required this.parking_capcity_full,
    required this.distance,
    required this.router_link
  });

  static ParkingModel fromJson(Map<String,dynamic> data){
    return ParkingModel(
      parking_id: data['parking_id'], 
      parking_name_fa: data['parking_name_fa'], 
      parking_name_en: data['parking_name'], 
      parking_like: data['parking_like'], 
      parking_image: data['parking_image'], 
      parking_capcity: data['capacity'], 
      parking_capcity_full: data['capacity_full'], 
      distance: data['distanse'],
      router_link: data['router_link']
    );
  }
}