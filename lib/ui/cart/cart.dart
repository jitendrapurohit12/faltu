import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/bloc/cart_bloc.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/ui/components/cart_list_ui.dart';
import 'package:faltu/utils/method_helper.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  CartState createState() {
    return new CartState();
  }
}

class CartState extends State<Cart> {
  CartBloc _bloc;
  double totalAmount = 0;
  List<IndividualProduct> productList = List();

  @override
  void initState() {
    super.initState();
    _bloc = CartBloc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.CART),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StreamBuilder(
              stream: _bloc.cartStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UIHelper.getTotalPriceLayout(
                          (snapshot.data.documents as List<DocumentSnapshot>)
                              .length,
                          getTotalAmount(snapshot.data.documents)));
                } else {
                  return Container();
                }
              },
            ),
            StreamBuilder(
                stream: _bloc.cartStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CartListUI(snapshot.data.documents, null,true);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            SizedBox(height: 24),
            StreamBuilder(
              stream: _bloc.cartStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return UIHelper.getOrderSummary(
                      getTotalAmount(snapshot.data.documents), 0.0);
                } else {
                  return Container();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0, right: 8.0),
              child: MaterialButton(
                onPressed: () =>
                    Navigation.addressSelection(context, productList),
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: UIHelper.rowWithTextAndIcon(
                    title: Constants.CONTINUE,
                    icon: Icons.arrow_forward,
                    color: Colors.white),
                color: Colors.black,
                splashColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  double getTotalAmount(List<DocumentSnapshot> snapshotList) {
    totalAmount = 0;
    productList.clear();

    snapshotList.forEach((document) {
      productList.add(IndividualProduct.fromJson(document.data));
      int price = int.parse(IndividualProduct.fromJson(document.data).price);
      int discount =
          int.parse(IndividualProduct.fromJson(document.data).discount ?? 0);
      totalAmount += MethodHelper.calculateDiscountedPrice(price, discount);
    });

    return totalAmount;
  }
}
