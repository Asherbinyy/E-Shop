class ChangeCartModel {
  bool ? status;
  String ? message;
  ChangeCartData ? data;
  ChangeCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ChangeCartData.fromJson(json['data']) : null;
  }
}

class ChangeCartData {
  int? id;
  int ?quantity;
  CartProductData ? product;
  ChangeCartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? new CartProductData.fromJson(json['product']) : null;
  }

}

class CartProductData {
  int ? id;
  dynamic price;
  dynamic oldPrice;
  int ? discount;
  String?  image;
  CartProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }

}