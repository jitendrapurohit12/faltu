import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/bloc/bloc_provider.dart';
import 'package:faltu/firebase_services/firebase_services.dart';

class CartBloc implements BlocBase {
  FirebaseService _firebaseService;

  //controller
  StreamController<QuerySnapshot> cartController =
      StreamController<QuerySnapshot>.broadcast();

  //stream and sink
  StreamSink<QuerySnapshot> get cartSink => cartController.sink;

  Stream<QuerySnapshot> get cartStream =>
      cartController.stream.asBroadcastStream();

  CartBloc() {
    _firebaseService = FirebaseService();
    _firebaseService.getCart.listen((product) {
      cartSink.add(product);
    });
  }

  @override
  void dispose() {
    cartController.close();
  }
}
