import 'package:flutter/material.dart';
import '../../database/user.dart';
import '../../models/UserSql.dart';
import 'dart:async';
import 'package:intl/intl.dart';


class UserInterface extends StatefulWidget {
  final String title;

  UserInterface({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserInterfaceState();
  }
}

class _UserInterfaceState extends State<UserInterface> {

  Future<List<User>> users;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastActiveController = TextEditingController();
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
    dbHelper = UserSql();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      users = dbHelper.getUsers();
    });
  }

  clearForm() {
    nameController.text = "";
    emailController.text = "";
    imageController.text = "";
    passwordController.text = "";
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        User e = User(curUserId, name, email, image, password, DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now()));
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        User e = User(null, name, email, image, password, DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now()));
        dbHelper.save(e);
      }
      clearForm();
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
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => name = val,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (val) => val.length == 0 ? 'Enter Email' : null,
              onSaved: (val) => email = val,
            ),
            TextFormField(
              controller: imageController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Image'),
              validator: (val) => val.length == 0 ? 'Enter Image' : null,
              onSaved: (val) => image = val,
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (val) => val.length == 0 ? 'Enter Password' : null,
              onSaved: (val) => password = val,
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
                    clearForm();
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
              label: Text('Date Create'),
            ),
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
                      nameController.text = user.name;
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
                    Text(user.email ?? '-'),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curUserId = user.id;
                      });
                      emailController.text = user.email;
                    },
                  ),
                  DataCell(
                    Text(user.image ?? '-'),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curUserId = user.id;
                      });
                      imageController.text = user.image;
                    },
                  ),
                  DataCell(
                  Text(user.password ?? '-'),
                  onTap: () {
                    setState(() {
                      isUpdating = true;
                      curUserId = user.id;
                    });
                    passwordController.text = user.password;
                  }),
                  DataCell(
                    Text(user.lastActive ?? '-'),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curUserId = user.id;
                      });
                      lastActiveController.text = user.lastActive;
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

//          if (null == snapshot.data || snapshot.data.length == 0) {
//            return Text("No Data Found");
//          }
//
//          return CircularProgressIndicator();
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
            list(),
            form(),
          ],
        ),
      ),
    );
  }
}
