import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/listeners/confirmation_listener.dart';
import 'package:faltu/listeners/filter_and_sort_listener.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/shared_preferences/set_preferences.dart';
import 'package:faltu/utils/method_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UIHelper {
  static Widget addressAppbar(BuildContext context, String title) {
    return AppBar(title: Text(title), actions: <Widget>[
      IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigation.newAddress(context, null))
    ]);
  }

  static Widget rowWithIconAndText(
      {String title, IconData icon, Color color = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: color,
        ),
        SizedBox(width: 16),
        Text(
          title,
          style: TextStyle(color: color),
        )
      ],
    );
  }

  static Widget rowWithTextAndIcon(
      {String title, IconData icon, Color color = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: color),
        ),
        SizedBox(width: 16),
        Icon(
          icon,
          color: color,
        ),
      ],
    );
  }

  static Widget logInButton(Widget child, Color background) {
    return Container(
        width: 250.0,
        height: 50.0,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.all(const Radius.circular(25.0)),
        ),
        child: child);
  }

  static Widget buttonText(String text, Color textColor) {
    return Text(
      text,
      style: new TextStyle(
        color: textColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.3,
      ),
    );
  }

  static Widget circularProgress() {
    return CircularProgressIndicator(
      backgroundColor: Colors.black,
      strokeWidth: 2.0,
    );
  }

  static Widget extendedCircle(
      {Color backgroundColor = Colors.white70,
      Color borderColor = Colors.white,
      double borderWidth = 2.0,
      double height = 200.0}) {
    return FractionallySizedBox(
      heightFactor: 2.0,
      widthFactor: 2.0,
      alignment: Alignment.bottomCenter,
      child: Container(
        height: height,
        width: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: borderWidth),
        ),
      ),
    );
  }

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Something went wrong!'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          );
        });
  }

  static void showConfirmationDialog(BuildContext context, String message,
      int index, String positiveText, ConfirmationListener listener) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  )),
              FlatButton(
                  onPressed: () {
                    listener.success(index);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          );
        });
  }

  static getCarousel({BuildContext context, List<String> list}) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 300.0,
      width: width,
      child: Carousel(
        images: [
          NetworkImage(
              'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1'),
          NetworkImage(
              'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1'),
          NetworkImage(
              'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1'),
          NetworkImage(
              'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1'),
          NetworkImage(
              'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1'),
          NetworkImage(
              'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1'),
        ],
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.black,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        borderRadius: true,
      ),
    );
  }

  static roundedCard({double width = 300.0, double cardRadius = 12.0}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.network(
          'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1',
          fit: BoxFit.cover,
          width: width,
          height: 200.0,
        ),
      ),
    );
  }

  static homeTitleText(String text) {
    return Text(text,
        style: TextStyle(
            color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w500));
  }

  static Widget getPager(
      BuildContext context,
      int id,
      List<String> images,
      PageController controller,
      double width,
      double height,
      bool needRoundedCorners) {
    return Container(
      width: width,
      height: height,
      child: Hero(
        tag: id,
        child: PageView(
            scrollDirection: Axis.horizontal,
            children: images
                .map((url) => needRoundedCorners
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: CachedNetworkImage(
                          imageUrl: url,
                          placeholder: Icon(Icons.file_download),
                          errorWidget: Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: url,
                        placeholder: Icon(Icons.file_download),
                        errorWidget: Icon(Icons.error),
                        fit: BoxFit.cover,
                      ))
                .toList(),
            controller: controller),
      ),
    );
  }

  static Widget getCenteredPager(
      BuildContext context,
      int id,
      List<String> images,
      PageController controller,
      double width,
      double height,
      bool needRoundedCorners) {
    return Container(
      width: width,
      height: height,
      child: Hero(
        tag: id,
        child: PageView(
            scrollDirection: Axis.horizontal,
            children: images
                .map(
                  (url) => Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: CachedNetworkImage(
                          imageUrl: url,
                          placeholder: Icon(Icons.file_download),
                          errorWidget: Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      )),
                )
                .toList(),
            controller: controller),
      ),
    );
  }

  static Widget listUnitDetails(IndividualProduct unit) {
    final price = int.parse(unit.price);
    final discount = int.parse(unit.discount ?? 0);
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                unit.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
              Text(
                unit.color,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              getPriceWidget(
                  discount,
                  price,
                  MethodHelper.calculateDiscountedPrice(price, discount),
                  Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  static Widget getPriceWidget(
      int discount, int price, double discountedPrice, Color textColor) {
    if (discount == 0) {
      return Container(
          decoration: customContainerDecoration(
              Color.fromRGBO(0, 0, 255, 0.5), Colors.blue, 1.0, 4.0),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(price.toString(), style: TextStyle(color: textColor)),
          ));
    } else {
      return Container(
        child: Row(
          children: <Widget>[
            Container(
                decoration: customContainerDecoration(
                    Color.fromRGBO(255, 0, 0, 0.1), Colors.redAccent, 1.0, 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(price.toString(),
                      style: TextStyle(color: textColor)),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: customContainerDecoration(
                      Color.fromRGBO(0, 255, 0, 0.1),
                      Colors.greenAccent,
                      1.0,
                      4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(discountedPrice.floor().toString(),
                        style: TextStyle(color: textColor)),
                  )),
            ),
            Container(
                decoration: customContainerDecoration(
                    Color.fromRGBO(0, 255, 0, 0.1),
                    Colors.greenAccent,
                    1.0,
                    4.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('$discount% off',
                      style: TextStyle(color: textColor)),
                )),
          ],
        ),
      );
    }
  }

  static BoxDecoration customContainerDecoration(
      Color color, Color borderColor, double borderWidth, double radius) {
    return BoxDecoration(
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(radius));
  }

  static BoxDecoration customContainerDecorationWithImage(Color color,
      Color borderColor, double borderWidth, double radius, String url) {
    return BoxDecoration(
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
        image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop)),
        borderRadius: BorderRadius.circular(radius));
  }

  static Widget filterAndSort(FAndSListener listener) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () => listener.filter(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.settings_ethernet),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Filter',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () => listener.sort(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.sort),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sort By',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  static Widget profileUnit(String title, String description, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 4.0, bottom: 4.0),
      child: Container(
        decoration:
            customContainerDecoration(Colors.white, Colors.black54, 1.0, 4.0),
        child: ListTile(
          title: Text(title),
          subtitle: Text(description),
          leading: Icon(icon),
        ),
      ),
    );
  }

  static Widget textField(int maxLength, TextInputType textType, String hint,
      TextEditingController controller) {
    return TextField(
      autofocus: false,
      controller: controller,
      maxLength: maxLength,
      maxLines: textType == TextInputType.multiline ? 2 : 1,
      keyboardType: textType,
      decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
          border:
              UnderlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
    );
  }

  static getTextSpan(String title, String span) {
    return TextSpan(
        text: title,
        style: TextStyle(
            color: Colors.grey, fontSize: 16.0, fontWeight: FontWeight.w400),
        children: <TextSpan>[
          TextSpan(
              text: span,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400))
        ]);
  }

  static orderStatusUI(String status, double width) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.black,
          radius: 8.0,
        ),
        Container(
          width: width / 4.5,
          height: 2.0,
          color: int.parse(status) > 1 ? Colors.black : Colors.grey,
        ),
        CircleAvatar(
          backgroundColor: int.parse(status) > 1 ? Colors.black : Colors.grey,
          radius: 8.0,
        ),
        Container(
          width: width / 4.5,
          height: 2.0,
          color: int.parse(status) > 2 ? Colors.black : Colors.grey,
        ),
        CircleAvatar(
          backgroundColor: int.parse(status) > 2 ? Colors.black : Colors.grey,
          radius: 8.0,
        ),
        Container(
          width: width / 4.5,
          height: 2.0,
          color: int.parse(status) > 3 ? Colors.black : Colors.grey,
        ),
        CircleAvatar(
          backgroundColor: int.parse(status) > 3 ? Colors.black : Colors.grey,
          radius: 8.0,
        )
      ],
    ));
  }

  static orderStatusTextUI(double width) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: MethodHelper.getOrderStatusList()
            .map((status) => Text(
                  status.toUpperCase(),
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w400),
                ))
            .toList());
  }

  static showProgressDialog({BuildContext context, String message}) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text(message)],
                  ),
                ),
              )
            ],
          );
        });
  }

  static getStringStreamBuilderWithBorder(
      BuildContext context,
      Observable<String> stream,
      changed,
      String label,
      TextEditingController controller,
      TextInputType inputType,
      int maxLength) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) => TextField(
            autofocus: false,
            onChanged: changed,
            maxLength: maxLength,
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
                labelText: label,
                errorText: snapshot.error,
                contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0))),
          ),
    );
  }

  static getStringStreamBuilderWithoutBorder(
      BuildContext context,
      Observable<String> stream,
      changed,
      String label,
      TextEditingController controller,
      TextInputType inputType,
      int maxLength) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) => TextField(
            autofocus: false,
            onChanged: changed,
            controller: controller,
            maxLength: maxLength,
            maxLines: inputType == TextInputType.multiline ? 2 : 1,
            keyboardType: inputType,
            decoration: InputDecoration(
                hintText: label,
                errorText: snapshot.error,
                contentPadding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0))),
          ),
    );
  }

  static void showLogoutDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  )),
              FlatButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    SetPreferences.clear();
                    Navigation.signIn(context);
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          );
        });
  }

  static SnackBar getSnackbar(String content) {
    return SnackBar(
      content: Text(content),
      action: SnackBarAction(label: 'VIEW', onPressed: () {}),
    );
  }

  static Widget getOrderSummary(double payableAmount, double shippingCharges) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Constants.ORDER_SUMMARY_TEXT,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(Constants.TOTAL_AMOUNT),
              Text('${Constants.RUPEE} $payableAmount')
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(Constants.SHIPPING_CHARGES),
              Text(shippingCharges == 0
                  ? 'FREE'
                  : '${Constants.RUPEE} $payableAmount')
            ],
          ),
          SizedBox(height: 8.0),
          Divider(),
          SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(Constants.PAYABLE_AMOUNT,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
              Text(
                '${Constants.RUPEE} ${payableAmount + shippingCharges}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            ],
          ),
          SizedBox(height: 6.0),
          Divider()
        ],
      ),
    );
  }

  static getTotalPriceLayout(int itemCount, double totalPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '$itemCount Items',
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        Text(
          '${Constants.RUPEE} $totalPrice',
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 18),
        )
      ],
    );
  }
}
