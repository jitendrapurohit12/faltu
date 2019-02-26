import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appbar {

  static Widget appbar(BuildContext context, String title, bool showActions) {
    return AppBar(
      title: Text(title),
      actions: showActions
          ? <Widget>[
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigation.cart(context);
            }),
        IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              UIHelper.showLogoutDialog(context, 'Would you really like to logout?');
            })
      ]
          : null,
    );
  }
}