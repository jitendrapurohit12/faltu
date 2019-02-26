import 'package:faltu/constants/constants.dart';
import 'package:faltu/models/production/drawer_items.dart';
import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/ui/dashboard/profile.dart';
import 'package:faltu/ui/home/men_products.dart';
import 'package:faltu/ui/home/my_wishlist.dart';
import 'package:faltu/ui/home/second_fragment.dart';
import 'package:faltu/ui/home/women_products.dart';
import 'package:faltu/ui/profile/orders.dart';
import 'package:faltu/utils/firestore_helper.dart';
import 'package:faltu/utils/ly_appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final drawerItems = [
    DrawerItems(Constants.APP_NAME, Icons.home),
    DrawerItems(Constants.MEN, Icons.perm_identity),
    DrawerItems(Constants.WOMEN, Icons.face),
    DrawerItems(null, Icons.add),
    DrawerItems(Constants.MY_ACCOUNT, Icons.account_box),
    DrawerItems(Constants.MY_ORDERS, Icons.shopping_cart),
    DrawerItems(Constants.MY_WISHLIST, Icons.favorite),
    DrawerItems(null, Icons.add),
    DrawerItems(Constants.OUR_STORY, Icons.bookmark),
    DrawerItems(Constants.BLOG, Icons.blur_on),
    DrawerItems(null, Icons.add),
    DrawerItems(Constants.CONTACT_US, Icons.contacts),
    DrawerItems(Constants.RATE_THE_APP, Icons.shop)
  ];

  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _selectedDrawerIndex = 0;
  SharedPreferences _prefs;

  initState() {
    super.initState();
    initPrefs();
    FirestoreHelper();
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        Navigation.secondFragment(context);
        break;
      case 1:
        Navigation.category(context, Constants.MEN);
        break;
      case 2:
        Navigation.category(context, Constants.WOMEN);
        break;
      case 4:
        Navigation.profile(context);
        break;
      case 5:
        Navigation.myOrders(context);
        break;
      case 6:
        Navigation.myWishlist(context);
        break;
    }
  }

  _onSelectItem(int index) {
    Navigator.of(context).pop();
    _getDrawerItemWidget(index);
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      DrawerItems item = widget.drawerItems[i];
      switch (i) {
        case 3:
        case 7:
        case 10:
          drawerOptions.add(Divider());
          break;
        default:
          drawerOptions.add(ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          ));
      }
    }

    return Scaffold(
      appBar: Appbar.appbar(context, Constants.APP_NAME, true),
      drawer: Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: _prefs?.getString(Constants.NAME) != null
                    ? Text(_prefs.getString(Constants.NAME))
                    : Container(),
                accountEmail: _prefs?.getString(Constants.EMAIL) != null
                    ? Text(_prefs?.getString(Constants.EMAIL))
                    : Container(),
                currentAccountPicture: _prefs?.getString(Constants.URL) != null
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage(_prefs?.getString(Constants.URL)),
                      )
                    : Container(),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: drawerOptions)
            ],
          ),
        ),
      ),
      body: SecondFragment(),
    );
  }

  void initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefs = prefs;
    });
  }
}
