import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class SecondFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UIHelper.getCarousel(context: context),
          Padding(
              padding: EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 12.0),
              child: UIHelper.homeTitleText('Men')),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: UIHelper.roundedCard(width: width),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 12.0),
              child: UIHelper.homeTitleText('Women')),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: UIHelper.roundedCard(width: width),
            ),
          )
        ],
      ),
    );
  }
}
