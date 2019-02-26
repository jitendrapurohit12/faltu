import 'package:faltu/bloc/wishlist_bloc.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/ui/components/wishlist_ui.dart';
import 'package:faltu/utils/ly_appbar.dart';
import 'package:flutter/material.dart';

class MyWishlist extends StatefulWidget {

  @override
  _MyWishlistState createState() => _MyWishlistState();
}

class _MyWishlistState extends State<MyWishlist> {

  WishlistBloc _wishlistBloc;

  @override
  void initState() {
    super.initState();
    _wishlistBloc = WishlistBloc();
  }

  @override
  void dispose() {
    _wishlistBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.appbar(context, Constants.MY_WISHLIST, true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
                stream: _wishlistBloc.wishlistStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return WishlistUI(snapshot.data.documents);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
