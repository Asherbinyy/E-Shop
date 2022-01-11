class GetCartsModel {
  bool ? status;
  GetCartData ? data;


  GetCartsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  GetCartData.fromJson(json['data']) : null;
  }

}

class GetCartData {
  List<CartItems> ?cartItems=[];
  dynamic subTotal;
  dynamic total;


  GetCartData.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      json['cart_items'].forEach((v) {
        cartItems?.add(CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }

}

class CartItems {
  int? id;
  int ?quantity;
  CartItemData ?product;


  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? new CartItemData.fromJson(json['product']) : null;
  }

}

class CartItemData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int ?discount;
  String? image;
  String ?name;
  String ?description;
  List<String> ?images;
  bool? inFavorites;
  bool ?inCart;



  CartItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}