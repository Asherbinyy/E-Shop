class HomeModel {
  bool ? status;
  HomeData ? data;

  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  HomeData.fromJson(json['data']) : null;
  }

}

class HomeData {
  List<HomeBanners> ? banners=[];
  List<HomeProducts> ? products=[];
  String ? ad;


  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      json['banners'].forEach((element) {
        banners?.add(new HomeBanners.fromJson(element));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((element) {
        products?.add(new HomeProducts.fromJson(element));
      });
    }
    ad = json['ad'];
  }


}

class HomeBanners {
  int ? id;
  String ? image;

  HomeBanners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }


}

class HomeProducts {
  int ? id;
  double ? price;
  double ? oldPrice;
  int ? discount;
  String ? image;
  String ? name;
  String ? description;
  List<String> ? images;
  bool ? inFavorites;
  bool ? inCart;



  HomeProducts.fromJson(Map<String, dynamic> json) {
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