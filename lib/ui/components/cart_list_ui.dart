import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/listeners/confirmation_listener.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:faltu/utils/method_helper.dart';
import 'package:faltu/utils/navigation_helper.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class CartListUI extends StatefulWidget {
  final List<DocumentSnapshot> snapshotList;
  final List<IndividualProduct> productList;
  final bool showRemoveButton;

  const CartListUI(this.snapshotList, this.productList, this.showRemoveButton);

  @override
  _CartListUIState createState() => _CartListUIState();
}

class _CartListUIState extends State<CartListUI>
    implements ConfirmationListener {
  List<IndividualProduct> cartList = List();

  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();

    if(widget.snapshotList != null) {
      widget.snapshotList.forEach((snapshot) {
        cartList.add(IndividualProduct.fromJson(snapshot.data));
      });
    }else if(widget.productList != null){
      cartList.addAll(widget.productList);
    }
  }

  @override
  void didUpdateWidget(CartListUI oldWidget) {
    super.didUpdateWidget(oldWidget);

    cartList.clear();

    if(widget.snapshotList != null) {
      widget.snapshotList.forEach((snapshot) {
        cartList.add(IndividualProduct.fromJson(snapshot.data));
      });
    }else if(widget.productList != null){
      cartList.addAll(widget.productList);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = 120.0;
    return Column(
      children: cartList.map((product){
        return GestureDetector(
            onTap: () => NavigationHelper.fetchDetailsAsnLaunchDetailsPage(context,product),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: height,
                    decoration: UIHelper.customContainerDecoration(
                        Colors.white70, Colors.black, 1.0, 6.0),
                    child: Row(
                      children: <Widget>[
                        UIHelper.getPager(
                            context,
                            int.parse(product.id),
                            product.images,
                            _controller,
                            height,
                            height,
                            true),
                        UIHelper.listUnitDetails(product)
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: widget.showRemoveButton ?
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              onPressed: () {
                                UIHelper.showConfirmationDialog(
                                    context,
                                    Constants.CARTLIST_DELETE_DIALOG,
                                    int.parse(product.id),
                                    Constants.REMOVE,
                                    this);
                              },
                              child: UIHelper.rowWithIconAndText(title:Constants.REMOVE.toUpperCase(),
                                  icon: Icons.delete, color: Colors.white),
                              color: Colors.black,
                              splashColor: Colors.white,
                            ) : Container(),
                          )
                        ],
                      ))
                ],
              ),
            ));
      }).toList(),
    );

    /*Expanded(
      child: ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () => NavigationHelper.fetchDetailsAsnLaunchDetailsPage(context,cartList[index]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: height,
                    decoration: UIHelper.customContainerDecoration(
                        Colors.white70, Colors.black, 1.0, 6.0),
                    child: Row(
                      children: <Widget>[
                        UIHelper.getPager(
                            context,
                            int.parse(cartList[index].id),
                            cartList[index].images,
                            _controller,
                            height,
                            height,
                            true),
                        UIHelper.listUnitDetails(cartList[index])
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              onPressed: () {
                                UIHelper.showConfirmationDialog(
                                    context,
                                    Constants.CARTLIST_DELETE_DIALOG,
                                    index,
                                    Constants.REMOVE,
                                    this);
                              },
                              child: UIHelper.rowWithIconAndText(title:Constants.REMOVE.toUpperCase(),
                              icon: Icons.delete, color: Colors.white),
                              color: Colors.black,
                              splashColor: Colors.white,
                            ),
                          )
                        ],
                      ))
                ],
              ),
            )),
      ),
    );*/
  }

  @override
  void success(int id) {
    MethodHelper.removeFromCart(context, id.toString());
  }
}
