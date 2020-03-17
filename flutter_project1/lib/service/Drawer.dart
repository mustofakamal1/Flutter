import 'package:flutter/material.dart';
import 'package:flutterproject1/screens/home/Login.dart';
import 'package:flutterproject1/screens/home/UserInterface.dart';
import 'package:flutterproject1/screens/home/OrderInterface.dart';
import 'package:flutterproject1/screens/home/home.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.contacts,
            text: 'User',
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserInterface())),
          ),
          _createDrawerItem(
            icon: Icons.event,
            text: 'Order',
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderInterface())),
          ),
          _createDrawerItem(
            icon: Icons.note,
            text: 'Log Out',
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login())),
          ),
          Divider(),
          _createDrawerItem(
              icon: Icons.collections_bookmark,
              text: 'Stock'),
          _createDrawerItem(
              icon: Icons.face,
              text: 'Authors'),
          _createDrawerItem(
              icon: Icons.stars,
              text: 'Useful Links'),
          Divider(),
          _createDrawerItem(
              icon: Icons.bug_report,
              text: 'Report an issue'),
          ListTile(
            title: Text('v1.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/Header.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              top: 20,
              left: 16.0,
              child: Text("E - Counter",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
          Positioned(
              bottom: 12,
              left: 16.0,
              child: Text("Menu",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

}

