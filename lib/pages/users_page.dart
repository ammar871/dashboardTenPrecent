import 'package:dashboard_web/pojo/users_orders.dart';
import 'package:dashboard_web/providers/provider_users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {


  late ProviderUsers _providerUsers;

  late List<DataUser> list;
  bool loading = false;

  getData() async {
    list = [];
    _providerUsers = Provider.of(context);

    _providerUsers.getDataUsers("1");
    list = _providerUsers.list;

    print(_providerUsers.list.length);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 40,
          ),
          TitleTableUsers(),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (BuildContext ctx, index) {
                return  ItemListUsers(list[index]);
              })
        ],
      ),
    );
  }
}

class ItemListUsers extends StatelessWidget {
  final DataUser dataUser;

  ItemListUsers(this.dataUser);


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Table(
          defaultColumnWidth: IntrinsicColumnWidth(),
          border: TableBorder.all(
              color: Colors.black.withOpacity(.5),
              style: BorderStyle.solid,
              width: 1),
          children: [
            TableRow(children: [
              Container(
                  padding: EdgeInsets.all(8),
                  width: 250,
                  child: Text(dataUser.createdAt,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 250,
                  child: Text(dataUser.email,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 250,
                  child: Text(dataUser.phone,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 250,
                  child: Text(dataUser.name,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 30,
                  child: Text(dataUser.id.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15.0))),
            ])
          ],
        ),
      );
  }
}

class TitleTableUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Table(
          defaultColumnWidth: IntrinsicColumnWidth(),
          border: TableBorder.all(
              color: Colors.black.withOpacity(.5),
              style: BorderStyle.solid,
              width: 1),
          children: [
            TableRow(children: [
              Container(
                  padding: EdgeInsets.all(8),
                  width: 250,
                  child: Text('تاريخ الانشاء',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 250,
                  child: Text('البريد الالكترونى',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 250,
                  child: Text('الهاتف',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 250,
                  child: Text('الاسم ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 30,
                  child: Text('#',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'bold', fontSize: 15.0))),
            ])
          ],
        ),
      );
  }
}
