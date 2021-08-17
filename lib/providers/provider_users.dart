import 'dart:convert';

import 'package:dashboard_web/pojo/users_orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class ProviderUsers extends ChangeNotifier{

  bool loading = true;
  List<DataUser> list = [];
  late UsersModel usersOrders;

  void getDataUsers(String page) async {
    var uri = Uri.parse("https://www.appweb.website/100top/api/dashboard/users?size=5&number=$page");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      loading = false;

      var dataCategories;

      dataCategories = json.decode(response.body);

      print(dataCategories);
      list = [];
      dataCategories["data"].forEach((element) {
        list.add(DataUser.fromJson(element));
      });

      usersOrders=UsersModel.fromJson(dataCategories);
      //    print(list[0].name);
    } else {
      loading = false;

    }
    notifyListeners();
  }



}