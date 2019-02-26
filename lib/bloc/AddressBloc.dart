import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/bloc/bloc_provider.dart';
import 'package:faltu/firebase_services/firebase_services.dart';

class AddressBloc implements BlocBase{

  FirebaseService firebaseService;

  //controller
  StreamController<QuerySnapshot> addressController = StreamController<QuerySnapshot>();

  //stream and sink
  StreamSink<QuerySnapshot> get addressSink => addressController.sink;
  Stream<QuerySnapshot> get addressStream => addressController.stream;

  AddressBloc(){
    firebaseService = FirebaseService();

    firebaseService.getAddresses.listen((addresses){
      addressSink.add(addresses);
    });
  }

  @override
  void dispose() {
    addressController.close();
  }

}