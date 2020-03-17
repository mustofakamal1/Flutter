import 'package:flutterproject1/screens/home/Login.dart';
import 'package:flutterproject1/screens/home/home.dart';
import 'package:flutterproject1/screens/authenticate/authenticate.dart';
import 'package:flutterproject1/screens/home/UserInterface.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject1/screens/home/Welcome.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // return either the Home or Authenticate widget
    return Welcome();
  }
}