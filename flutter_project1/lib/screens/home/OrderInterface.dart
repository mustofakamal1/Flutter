import 'package:flutter/material.dart';
import '../../database/order.dart';
import '../../models/OrderSql.dart';
import 'dart:async';


class OrderInterface extends StatefulWidget {
  final String title;

  OrderInterface({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OrderInterfaceState();
  }
}

class _OrderInterfaceState extends State<OrderInterface> {
  //
  Future<List<Order>> orders;
  TextEditingController numberController = TextEditingController();
  TextEditingController pidController = TextEditingController();
  TextEditingController jidController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController order_dateController = TextEditingController();
  int curOrderId;
  String number;
  int pid;
  int jid;
  int nominal;
  String order_date;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = OrderSql();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      orders = dbHelper.getOrders();
    });
  }

  clearName() {
    numberController.text;
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Order e = Order(curOrderId, number, pid, jid, nominal, order_date);
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        Order e = Order(null, number, pid, jid, nominal, order_date);
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
              controller: numberController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => number = val,
            ),
            TextFormField(
              controller: pidController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (val) => val.length == 0 ? 'Enter Email' : null,
              onSaved: (val) => pid = int.parse(val),
            ),
            TextFormField(
              controller: jidController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (val) => val.length == 0 ? 'Enter Email' : null,
              onSaved: (val) => jid = int.parse(val),
            ),
            TextFormField(
              controller: nominalController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (val) => val.length == 0 ? 'Enter Email' : null,
              onSaved: (val) => nominal = int.parse(val),
            ),
            TextFormField(
              controller: order_dateController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (val) => val.length == 0 ? 'Enter Email' : null,
              onSaved: (val) => order_date = val,
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

  SingleChildScrollView dataTable(List<Order> orders) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('NUMBER'),
            ),
            DataColumn(
              label: Text('DELETE'),
            ),
            DataColumn(
              label: Text('PID'),
            ),
            DataColumn(
              label: Text('JID'),
            ),
            DataColumn(
              label: Text('NOMINAL'),
            ),
            DataColumn(
              label: Text('ORDER DATE'),
            )
          ],
          rows: orders
              .map(
                (order) => DataRow(cells: [
                  DataCell(
                    Text(order.number),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curOrderId = order.id;
                      });
                      numberController.text = order.number;
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dbHelper.delete(order.id);
                      refreshList();
                    },
                  )),
                  DataCell(
                    Text(order.pid.toString()),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curOrderId = order.id;
                      });
                      pidController.text = order.pid.toString();
                    },
                  ),
                  DataCell(
                    Text(order.jid ?? '-'),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curOrderId = order.id;
                      });
                      jidController.text = order.jid.toString();
                    },
                  ),
                  DataCell(
                    Text(order.nominal ?? '-'),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curOrderId = order.id;
                      });
                      nominalController.text = order.nominal.toString();
                    },
                  ),
                  DataCell(
                    Text(order.order_date ?? '-'),
                    onTap: () {
                      setState(() {
                        isUpdating = true;
                        curOrderId = order.id;
                      });
                      order_dateController.text = order.order_date;
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
        future: orders,
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
