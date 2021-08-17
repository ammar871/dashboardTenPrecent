import 'dart:convert';

import 'package:dashboard_web/pojo/orders_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class ProviderOrders extends ChangeNotifier{

List<DataOrders> list=[];
bool loading=false;
late OrdersModel ordersModel;

void getOrdersData(String page) async {
  loading = true;
  var uri = Uri.parse("https://www.appweb.website/100top/api/dashboard/orders?size=5&number=$page");
  final response = await http.get(uri);

  if (response.statusCode == 200) {

    var dataCategories;

    dataCategories = json.decode(response.body);

    print(dataCategories);
    // list= List<ModelCategory>.from(l.map((model)=> ModelCategory.fromJson(model)));
    list = [];

    dataCategories["data"].forEach((element) {
      list.add(DataOrders.fromJson(element));
    });

    ordersModel = OrdersModel.fromJson(dataCategories);
    loading = false;
    notifyListeners();

  } else {
    loading = false;
    notifyListeners();
  }
  notifyListeners();
}


}