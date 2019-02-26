import 'package:faltu/constants/constants.dart';
import 'package:faltu/models/individual/combined_product.dart';
import 'package:faltu/utils/method_helper.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class WearableUnitDetails extends StatefulWidget {
  final CombinedProduct product;
  double discountedPrice;
  int price, discount, id;
  String selectedSize;
  List<String> images;

  WearableUnitDetails(this.product) {
    this.price = int.parse(product.price);
    this.discount = int.parse(product.discount);
    this.id = int.parse(product.id);
    this.images = product.images;
    discountedPrice = MethodHelper.calculateDiscountedPrice(price, discount);
  }

  @override
  WearableUnitDetailsState createState() {
    return new WearableUnitDetailsState();
  }
}

class WearableUnitDetailsState extends State<WearableUnitDetails> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height / 1.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Faltu'),
      ),
      body: Container(
        color: Colors.black54,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: UIHelper.getCenteredPager(
                    context,
                    widget.id,
                    widget.images,
                    _controller,
                    width,
                    height,
                    false),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.product.name,
                      style: TextStyle(fontSize: 32.0, color: Colors.white),
                    ),
                    UIHelper.getPriceWidget(widget.discount, widget.price,
                        widget.discountedPrice, Colors.white),
                    Divider(color: Colors.white),
                    getColorOptions(),
                    Divider(color: Colors.white),
                    getSizeOptions(),
                    Padding(padding: EdgeInsets.all(24.0)),
                    getButtonLayout()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getColorOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Colors',
            style:
            TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: widget.product.colors
                .map((color) =>
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: UIHelper.customContainerDecoration(
                        Color(MethodHelper.getColorCode(color)),
                        widget.product.color == color ? Colors.white : Color(MethodHelper.getColorCode(color)),
                        2.0,
                        16.0),
                  ),
                ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget getSizeOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Size',
            style:
            TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 8.0,
            runSpacing: 4.0,
            children: widget.product.size
                .map((size) =>
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedSize = size;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      child: Text(
                        size,
                        style: TextStyle(
                            color: isSelected(size)
                                ? Colors.white
                                : Colors.black),
                      ),
                      backgroundColor: isSelected(size)
                          ? Colors.blue
                          : Colors.white,
                    ),
                  ),
                ))
                .toList(),
          ),
        ),
      ],
    );
  }

  bool isSelected(String size) {
    return widget.selectedSize == null ? false : widget.selectedSize == size;
  }

  Widget getButtonLayout() {
    return Column(
      children: <Widget>[
        MaterialButton(
            onPressed: () => MethodHelper.addToWishlist(context, widget.product),
            color: Colors.black,
            splashColor: Colors.white,
            child: UIHelper.rowWithIconAndText(
                title: Constants.BUTTON_ADD_TO_WISHLIST,
                icon: Icons.star_border,
                color: Colors.white)),
        SizedBox(height: 8.0),
        MaterialButton(
            onPressed: () =>
                MethodHelper.addToCart(context, widget.product),
            color: Colors.black,
            splashColor: Colors.white,
            child: UIHelper.rowWithIconAndText(
                title: Constants.BUTTON_ADD_TO_CART,
                icon: Icons.add_shopping_cart, color:
                Colors.white))
      ],
    );
  }
}
