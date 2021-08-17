import 'dart:convert';

import 'package:dashboard_web/pojo/products_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProviderProducts extends ChangeNotifier {
  bool loading = true;
  List<DataProduct> list = [];
  late ProductsModel _productsModel;

  void getProductsData(String page) async {
    var uri = Uri.parse(
        "https://www.appweb.website/100top/api/dashboard/products?size=5&number=$page");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      loading = false;
      var dataCategories;
      dataCategories = json.decode(response.body);
      list = [];
      dataCategories["data"].forEach((element) {
        list.add(DataProduct.fromJson(element));
      });
      print(list.length);
      notifyListeners();
      _productsModel = ProductsModel.fromJson(dataCategories);

      //    print(list[0].name);
    } else {
      loading = false;
    }
    notifyListeners();
  }

  bool loadingDelete = false;

  void deleteProduct(int id) async {
    loadingDelete = true;
    var uri = Uri.parse(
        "https://www.appweb.website/100top/api/dashboard/delete-product?id=$id");
    final response = await http.post(uri);

    if (response.statusCode == 200) {
      loadingDelete = false;

      print("delete Success");
    } else {
      loadingDelete = false;
    }
    notifyListeners();
  }
}
