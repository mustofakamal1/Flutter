import 'package:flutter/material.dart';
import '../../database/user.dart';
import 'dart:async';
import 'package:flutterproject1/models/DBHelper.dart';

class DBTestPage extends StatefulWidget {
  final String title;

  DBTestPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DBTestPageState();
  }
}

class _DBTestPageState extends State<DBTestPage> {
  //
  Future<List<User>> users;
  TextEditingController controller = TextEditingController();
  int curUserId;
  String name;
  String email;
  String image;
  String password;
  String lastActive;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      users = dbHelper.getUsers();
    });
  }

  clearName() {
    controller.text;
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        User e = User(curUserId, name, email, image, password, lastActive);
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        User e = User(null, name, email, image, password, lastActive);
        dbHelper.save(e);
      }
      clearName();
      refreshList();
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => name = val,
            ),
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (val) => val.length == 0 ? 'Enter Email' : null,
              onSaved: (val) => email = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? 'UPDATE' : 'ADD'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    clearName();
                  },
                  child: Text('CANCEL'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView dataTable(List<User> users) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('NAME'),
            ),
            DataColumn(
              label: Text('DELETE'),
            ),
            DataColumn(
              label: Text('EMAIL'),
            ),
            DataColumn(
              label: Text('IMAGE'),
            ),
            DataColumn(
              label: Text('PASSWORD'),
            ),
            DataColumn(
              label: Text('LAST_ACTIVE'),
            )
          ],
          rows: users
              .map(
                (user) => DataRow(cells: [
                  DataCell(
                    Text(user.name),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curUserId = user.id;
                      });
                      controller.text = user.name;
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dbHelper.delete(user.id);
                      refreshList();
                    },
                  )),
                  DataCell(
                    Text(user.email),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curUserId = user.id;
                      });
                      controller.text = user.email;
                    },
                  ),
                  DataCell(
                    Text(user.image ?? '-'),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curUserId = user.id;
                      });
                      controller.text = user.image;
                    },
                  ),
                  DataCell(
                    Text(user.password ?? '-'),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curUserId = user.id;
                      });
                      controller.text = user.password;
                    },
                  ),
                  DataCell(
                    Text(user.lastActive ?? '-'),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curUserId = user.id;
                      });
                      controller.text = user.lastActive;
                    },
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          else {
            return Text('No Data');
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('E - Counter'),
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}
