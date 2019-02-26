import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/bloc/bloc_provider.dart';
import 'package:faltu/firebase_services/firebase_services.dart';

class WishlistBloc implements BlocBase {
  FirebaseService firebaseServices;

  //controllers
  StreamController<QuerySnapshot> wishlistController =
      StreamController<QuerySnapshot>();

  //stream and sink
  StreamSink<QuerySnapshot> get wishlistSink => wishlistController.sink;

  Stream<QuerySnapshot> get wishlistStream => wishlistController.stream;

  WishlistBloc() {
    firebaseServices = FirebaseService();

    firebaseServices.getWishlist.listen((product) {
      wishlistSink.add(product);
    });
  }

  @override
  void dispose() {
    wishlistController.close();
  }
}
