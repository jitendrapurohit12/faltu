import 'package:faltu/constants/constants.dart';
import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/shared_preferences/get_preferences.dart';
import 'package:faltu/utils/ly_appbar.dart';
import 'package:faltu/utils/method_helper.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  @override
  MyProfileState createState() {
    return new MyProfileState();
  }
}

class MyProfileState extends State<MyProfile> {
  String _name, _url, _email, _phone;
  double _width, _height;

  @override
  void initState() {
    super.initState();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Appbar.appbar(context, Constants.MY_ACCOUNT, true),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: _width,
              height: _height / 2.5,
              decoration: UIHelper.customContainerDecoration(
                  Colors.black, Colors.black, 2.0, 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(_url != null ? _url : null),
                    radius: 56.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _name != null
                        ? Text(
                            _name,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w400),
                          )
                        : Container(),
                  ),
                  _email != null
                      ? Text(
                          _email,
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w300),
                        )
                      : Container(),
                  _phone != null
                      ? Text(
                          _phone,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w200),
                        )
                      : Container()
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
                itemCount: MethodHelper.getProfileTitleList().length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: ()=> selectedProfileOption(index),
                    child: UIHelper.profileUnit(
                        MethodHelper.getProfileTitleList()[index],
                        MethodHelper.getProfileDescriptionList()[index],
                        getIconData(index)),
                  );
                }),
          )
        ],
      ),
    );
  }

  void getPreferences() async {
    await GetPreferences.getName().then((userName) {
      setState(() {
        _name = userName;
      });
    });
    await GetPreferences.getURL().then((imageUrl) {
      setState(() {
        _url = imageUrl;
      });
    });
    await GetPreferences.getEmail().then((email) {
      setState(() {
        _email = email;
      });
    });
    await GetPreferences.getPhone().then((phone) {
      setState(() {
        _phone = phone;
      });
    });
  }

  IconData getIconData(int index) {
    switch (index) {
      case 0:
        return Icons.face;
      case 1:
        return Icons.home;
      case 2:
        return Icons.shopping_cart;
      default:
        return Icons.shop;
    }
  }

  selectedProfileOption(int index) {
    switch(index){
      case 0:
        Navigation.editProfile(context);
        break;
      case 1:
        Navigation.address(context);
        break;
      case 2:
        Navigation.myOrders(context);
        break;
    }
  }
}
