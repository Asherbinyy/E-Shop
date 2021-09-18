class CategoryProductModel {
  bool ? status;
  CategoryProductData ? data;


  CategoryProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  CategoryProductData.fromJson(json['data']) : null;
  }

}

class CategoryProductData {
  int ? currentPage;
  List<ProductCategoryData>? data=[];
  String ? firstPageUrl;
  int ?from;
  int ?lastPage;
  String ?lastPageUrl;
  String? path;
  int ?perPage;
  int ?to;
  int ?total;


  CategoryProductData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {data?.add( ProductCategoryData.fromJson(v));
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

class ProductCategoryData {
  int ?id;
  dynamic price;
  dynamic oldPrice;
  int ?discount;
  String? image;
  String ?name;
  String ?description;
  List<String> ?images;
  bool ?inFavorites;
  bool ?inCart;

  ProductCategoryData.fromJson(Map<String, dynamic> json) {
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