class CategoriesModel {
  bool?  status;
  CategoryData ? categoriesData;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoriesData = json['data'] != null ? new CategoryData.fromJson(json['data']) : null;
  }
}

class CategoryData {
  int ? currentPage;
  List<Data> ? dataList =[];
  String ? firstPageUrl;
  int ? from;
  int ? lastPage;
  String ? lastPageUrl;
  int ? nextPageUrl; ///null
  String ?path;
  int ? perPage;
  int ? prevPageUrl; ///null
  int ? to;
  int ? total;


  CategoryData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        dataList?.add( Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}

class Data {
  int ? id;
  String ? name;
  String ? image;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }


}