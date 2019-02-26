import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/bloc/bloc_provider.dart';
import 'package:faltu/firebase_services/firebase_services.dart';

class OrdersBloc implements BlocBase{

  FirebaseService firebaseServices;

  //controllers
  StreamController<QuerySnapshot> ordersController = StreamController<QuerySnapshot>();

  //stream and sink
  StreamSink<QuerySnapshot> get ordersSink => ordersController.sink;
  Stream<QuerySnapshot> get orderStream => ordersController.stream;

  OrdersBloc(){
    firebaseServices = FirebaseService();
    
    firebaseServices.getOrders.listen((orders){
      ordersSink.add(orders);
    });
  }

  @override
  void dispose() {
    ordersController.close();
  }

}