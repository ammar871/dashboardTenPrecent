/// data : [{"id":2,"user_id":26,"cart":"[{\"id\":16,\"quantity\":1}]","total_cost":70,"user":{"id":26,"name":"cvc fff","phone":"12345678","email":"ammarebrahim9@gmail.com"},"products":[{"id":16,"name":"شامبو دوف 700 مل حجم التوفير","desc":"تساقط","image":"https://www.appweb.website/100top/public/uploads/1625749898.png","category_id":6,"seller_id":1,"order_count":5,"price":70,"rate":4,"discount":63,"quantity":"1"}]},{"id":3,"user_id":26,"cart":"[{\"id\":1,\"quantity\":1},{\"id\":4,\"quantity\":1}]","total_cost":44,"user":{"id":26,"name":"cvc fff","phone":"12345678","email":"ammarebrahim9@gmail.com"},"products":[{"id":1,"name":"منظم","desc":"sdfhdsfgkdsg","image":"https://www.appweb.website/100top/public/uploads/1624132456.png","category_id":3,"seller_id":1,"order_count":5,"price":32,"rate":4,"discount":2,"quantity":"1"},{"id":4,"name":"كريم العود الملكي","desc":"مزيل عرق مرطب رائحة عطرة","image":"https://www.appweb.website/100top/public/uploads/1624451674.png","category_id":5,"seller_id":1,"order_count":5,"price":12,"rate":4,"discount":2,"quantity":"1"}]}]
/// size : 3

class OrdersModel {
 late List<DataOrders> _data;
 late int _size;

  List<DataOrders> get data => _data;
  int get size => _size;

  OrdersModel({
      required List<DataOrders> data,
      required int size}){
    _data = data;
    _size = size;
}

  OrdersModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(DataOrders.fromJson(v));
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


class DataOrders {
 late int _id;
 late int _userId;
  late String _cart;
 late int _totalCost;
late  User _user;
 late List<Products> _products;

  int get id => _id;
  int get userId => _userId;
  String get cart => _cart;
  int get totalCost => _totalCost;
  User get user => _user;
  List<Products> get products => _products;

  DataOrders({
      required int id,
      required int userId,
      required String cart,
      required int totalCost,
      required User user,
      required List<Products> products}){
    _id = id;
    _userId = userId;
    _cart = cart;
    _totalCost = totalCost;
    _user = user;
    _products = products;
}

 DataOrders.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _cart = json['cart'];
    _totalCost = json['total_cost'];
    _user = (json['user'] != null ? User.fromJson(json['user']) : null)!;
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['cart'] = _cart;
    map['total_cost'] = _totalCost;
    map['user'] = _user.toJson();
    map['products'] = _products.map((v) => v.toJson()).toList();
    return map;
  }

}



class Products {
 late int _id;
 late String _name;
 late  String _desc;
 late String _image;
 late int _categoryId;
 late int _sellerId;
 late  int _orderCount;
 late int _price;
 late int _rate;
 late  int _discount;
 late String _quantity;

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
  String get quantity => _quantity;

  Products({
      required int id,
      required String name,
      required String desc,
      required String image,
      required int categoryId,
      required int sellerId,
      required int orderCount,
      required int price,
      required int rate,
      required int discount,
      required String quantity}){
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
    _quantity = quantity;
}

  Products.fromJson(dynamic json) {
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
    _quantity = json['quantity'];
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
    map['quantity'] = _quantity;
    return map;
  }

}

/// id : 26
/// name : "cvc fff"
/// phone : "12345678"
/// email : "ammarebrahim9@gmail.com"

class User {
late  int _id;
late  String _name;
late String _phone;
late String _email;

  int get id => _id;
  String get name => _name;
  String get phone => _phone;
  String get email => _email;

  User({
      required int id,
      required String name,
      required String phone,
      required String email}){
    _id = id;
    _name = name;
    _phone = phone;
    _email = email;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    map['email'] = _email;
    return map;
  }

}