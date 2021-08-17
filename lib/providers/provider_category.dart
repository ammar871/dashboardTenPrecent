import 'dart:convert';

import 'package:dashboard_web/pojo/category.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProviderCategory extends ChangeNotifier {
  bool loading = true;
  bool loadingDelete = false;
  List<Data> list = [];
late Category category;
  void categoryData(String page) async {
    var uri = Uri.parse("https://www.appweb.website/100top/api/dashboard/categories?size=5&number=$page");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      loading = false;

      var dataCategories;

      dataCategories = json.decode(response.body);

      print(dataCategories);
      // list= List<ModelCategory>.from(l.map((model)=> ModelCategory.fromJson(model)));
      list = [];
      dataCategories["data"].forEach((element) {
        list.add(Data.fromJson(element));
      });

          category=Category.fromJson(dataCategories);
      //    print(list[0].name);
    } else {
      loading = false;

    }
    notifyListeners();
  }

  void categoryDeleting(int id) async {
    loadingDelete=true;
    var uri = Uri.parse("https://www.appweb.website/100top/api/dashboard/delete-category?id=$id");
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
