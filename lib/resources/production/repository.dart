import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/models/production/wearable_unit.dart';
import 'package:faltu/resources/production/api_provider.dart';

class Repository {
  ApiProvider _provider = ApiProvider();

  /*Future<WearableUnit> getWearableList() => _provider.getWearableList();

  Future<WearableUnit> getCartWearableList() => _provider.getCartWearableList();

  Future<AddressUnit> getAddressList() => _provider.getAddressList();

  Future<WearableUnit> getWishlist() => _provider.getWishlist();*/

  Future<Stream<DocumentSnapshot>> getOrderList() => _provider.getOrderList();
}
