

class ProductsModel {
 late List<DataProduct> _data;
 late  int _size;

  List<DataProduct> get data => _data;
  int get size => _size;

  ProductsModel({
      required List<DataProduct> data, 
      required int size}){
    _data = data;
    _size = size;
}


  ProductsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(DataProduct.fromJson(v));
      });
    }
    _size = json['size'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['data'] = _data.map((v) => v.toJson()).toList();
    map['size'] = _size;
    return map;
  }

}



class DataProduct {
 late int _id;
 late String _name;
 late String _desc;
 late String _image;
 late int _categoryId;
 late int _sellerId;
 late int _orderCount;
 late  int _price;
 late int _rate;
 late int _discount;

  int get id => _id;
  String get name => _name;
  String get desc => _desc;
  String get image => _image;
  int get categoryId => _categoryId;
  int get sellerId => _sellerId;
  int get orderCount => _orderCount;
  int get price => _price;
  int get rate => _rate;
  int get discount => _discount;

 DataProduct.name();

  DataProduct({
      required int id, 
      required String name, 
      required String desc, 
      required String image, 
      required int categoryId, 
      required int sellerId, 
      required int orderCount, 
      required int price, 
      required int rate, 
      required int discount}){
    _id = id;
    _name = name;
    _desc = desc;
    _image = image;
    _categoryId = categoryId;
    _sellerId = sellerId;
    _orderCount = orderCount;
    _price = price;
    _rate = rate;
    _discount = discount;
}

  DataProduct.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _desc = json['desc'];
    _image = json['image'];
    _categoryId = json['category_id'];
    _sellerId = json['seller_id'];
    _orderCount = json['order_count'];
    _price = json['price'];
    _rate = json['rate'];
    _discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['desc'] = _desc;
    map['image'] = _image;
    map['category_id'] = _categoryId;
    map['seller_id'] = _sellerId;
    map['order_count'] = _orderCount;
    map['price'] = _price;
    map['rate'] = _rate;
    map['discount'] = _discount;
    return map;
  }

}