class GetFavouritesModel {
  bool ? status;
  GetFavouritesData ? data;


  GetFavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  GetFavouritesData.fromJson(json['data']) : null;
  }

}

class GetFavouritesData {
  int ? currentPage;
  List<FavProductData> ? data =[];
  String ? firstPageUrl;
  int ? from;
  int ? lastPage;
  String ? lastPageUrl;
  String ? path;
  int ? perPage;
  int ? to;
  int ? total;

  GetFavouritesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data?.add( FavProductData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}

class FavProductData {
  int?id;
  ProductData ? product;

  FavProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ?  ProductData.fromJson(json['product']) : null;
  }

}

class ProductData {
  int ? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String ?image;
  List<String> ?images=[]; /// NOT IN API SO ITS ALWAYS NULL
  String ?name;
  String? description;


  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    images = json['images'];
    name = json['name'];
    description = json['description'];
  }

}