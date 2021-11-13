class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  /// i modified it for firestore
  String? password;
  String ? firebaseId ;
  ///
  String? image;
  int? points;
  int? credit;
  String? token;


  UserModel(
      {this.id,
        this.firebaseId,
        this.name,
        this.email,
        this.phone,
        this.password,
        this.image,
        this.points,
        this.credit,
        this.token, });

  UserModel.formJson(Map<String,dynamic> json ){
    id = json['id'];
    firebaseId = json['firebaseId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

  Map <String,dynamic> toJson(){
    return {
      "id":this.id,
      "firebaseId":this.firebaseId,
      "name":this.name,
      "email":this.email,
      "phone":this.phone,
      "image":this.image,
      "points":this.points,
      "credit":this.credit,
      "token":this.token,
    };
  }
}