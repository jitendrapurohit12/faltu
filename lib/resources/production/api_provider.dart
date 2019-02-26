import 'dart:async';
import 'dart:convert';

import 'package:faltu/models/individual/single_address.dart';
import 'package:faltu/models/individual/single_order.dart';
import 'package:faltu/models/individual/single_wearable.dart';
import 'package:faltu/models/production/address_unit.dart';
import 'package:faltu/models/production/wearable_unit.dart';
import 'package:http/http.dart' as client;
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiProvider {
  final url =
      'url will appear here!!!';

  Future<SingleWearable> getWearableList() async {
    return null;
  }

  Future<SingleWearable> getCartWearableList() async {
    return null;
  }

  Future<SingleAddress> getAddressList() async {
    return null;
  }

  Future<SingleWearable> getWishlist() async {
    return null;
  }

  Future<Stream<DocumentSnapshot>> getOrderList() async {
    return Firestore.instance.collection('orders').document('1').snapshots();
  }
}
