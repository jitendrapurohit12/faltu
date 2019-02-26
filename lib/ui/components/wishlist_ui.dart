import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/listeners/confirmation_listener.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:faltu/utils/method_helper.dart';
import 'package:faltu/utils/navigation_helper.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class WishlistUI extends StatefulWidget {
  final List<DocumentSnapshot> snapshotList;

  const WishlistUI(this.snapshotList);

  @override
  _WishlistUIState createState() => _WishlistUIState();
}

class _WishlistUIState extends State<WishlistUI>
    implements ConfirmationListener {
  List<IndividualProduct> wishList = List();

  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();

    widget.snapshotList.forEach((snapshot) {
      wishList.add(IndividualProduct.fromJson(snapshot.data));
    });
  }

  @override
  void didUpdateWidget(WishlistUI oldWidget) {
    super.didUpdateWidget(oldWidget);

    wishList.clear();

    widget.snapshotList.forEach((snapshot) {
      wishList.add(IndividualProduct.fromJson(snapshot.data));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = 120.0;
    return Expanded(
      child: ListView.builder(
        itemCount: wishList.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () => NavigationHelper.fetchDetailsAsnLaunchDetailsPage(context,wishList[index]),
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
                            int.parse(wishList[index].id),
                            wishList[index].images,
                            _controller,
                            height,
                            height,
                            true),
                        UIHelper.listUnitDetails(wishList[index])
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
                                    Constants.WISHLIST_DELETE_DIALOG,
                                    index,
                                    Constants.REMOVE,
                                    this);
                              },
                              child: Text(
                                Constants.REMOVE.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                              color: Colors.black,
                              splashColor: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              onPressed: () {},
                              child: Text(
                                Constants.ADD_TO_CART.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
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
    );
  }

  @override
  void success(int index) {
    MethodHelper.removeFromWishlist(context, wishList[index].id);
  }
}
