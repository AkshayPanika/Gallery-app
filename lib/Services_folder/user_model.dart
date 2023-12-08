

class UserModel{
  String? imageUrl;
  String? dateTime;
  UserModel({
    required this.imageUrl,
    required this.dateTime,
});

  UserModel.fromMap(Map<String,dynamic> map){
    imageUrl = map["imageUrl"];
    dateTime = map["dateTime"];
  }

  Map<String, dynamic> toMap(){
    return {
      "imageUrl":imageUrl,
      "dateTime":dateTime,
    };
  }
}