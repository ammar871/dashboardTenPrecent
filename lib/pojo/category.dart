/// data : [{"id":5,"name":"العناية بالبشرة","image":"https://www.appweb.website/100top/public/uploads/1624451772.png"},{"id":6,"name":"العناية بالشعر","image":"https://www.appweb.website/100top/public/uploads/1624452462.png"}]
/// size : 3

class Category {
 late List<Data> _data;
 late  int _size;

  List<Data> get data => _data;
  int get size => _size;

  Category({
      required List<Data> data,
      required int size}){
    _data = data;
    _size = size;
}

  Category.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
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

/// id : 5
/// name : "العناية بالبشرة"
/// image : "https://www.appweb.website/100top/public/uploads/1624451772.png"

class Data {
 late int _id;
  late String _name;
 late String _image;

  int get id => _id;
  String get name => _name;
  String get image => _image;

  Data({
      required int id,
      required String name,
      required String image}){
    _id = id;
    _name = name;
    _image = image;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }

}