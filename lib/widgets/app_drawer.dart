import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          new DrawerHeader(
              child: new Image.asset("images/drawer_header_img.jpg")),
          ListTile(
            title: new Text("Item 1"),
          ),
          ListTile(
            title: new Text("Item 2"),
          ),
        ],
      ),
    );
  }
}