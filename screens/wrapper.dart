import 'package:flutterproject1/screens/home/home.dart';
import 'package:flutterproject1/screens/authenticate/authenticate.dart';
import 'package:flutterproject1/screens/home/implement.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // return either the Home or Authenticate widget
    return DBTestPage();
  }
}