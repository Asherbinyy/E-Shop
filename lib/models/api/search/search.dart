class SearchModel {
  bool ? status;
  SearchData ? data;


  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  SearchData.fromJson(json['data']) : null;
  }

}

class SearchData {
  int ? currentPage;
  List<ProductSearchData> ?data =[];
  String ?firstPageUrl;
  int? from;
  int ?lastPage;
  String ?lastPageUrl;
  String ? path;
  int ?perPage;
  int? to;
  int? total;


  SearchData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data?.add( ProductSearchData.fromJson(v));
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

class ProductSearchData {
  int ? id;
  dynamic price;
  int ? discount; /// This Field Is not in Api so its always null
  String?  image;
  String ? name;
  String ? description;
  List<String>?  images;
  bool ? inFavorites;
  bool ? inCart;



  ProductSearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}