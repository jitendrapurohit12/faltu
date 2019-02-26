import 'package:faltu/constants/constants.dart';
import 'package:faltu/utils/ly_appbar.dart';
import 'package:flutter/material.dart';

class ThirdFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.appbar(context, Constants.WOMEN, true),
      body: Center(
        child: Text(
          'Third Fragment',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}