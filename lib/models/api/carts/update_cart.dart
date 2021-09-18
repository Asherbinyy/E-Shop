class UpdateCartModel {
  bool? status;
  String ?message;
  UpdateCartData ?data;


  UpdateCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UpdateCartData.fromJson(json['data']) : null;
  }

}

class UpdateCartData {
  CartUpdatedData ? cart;
  dynamic subTotal;
  dynamic total;

  UpdateCartData.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new CartUpdatedData.fromJson(json['cart']) : null;
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartUpdatedData {
  int? id;
  int ?quantity;

  CartUpdatedData({this.id, this.quantity,});

  CartUpdatedData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];

  }


}

