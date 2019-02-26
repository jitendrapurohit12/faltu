import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/bloc/app_bloc.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/listeners/bool_listener.dart';
import 'package:faltu/models/individual/profile.dart';
import 'package:faltu/models/individual/single_address.dart';
import 'package:faltu/shared_preferences/prefs.dart';
import 'package:faltu/utils/ui_helper.dart';

class FirebaseService {
  static const ORDERS = 'orders';
  static const ADDRESSES = 'address';
  static const PROFILE = 'profile';
  static const MY_ORDERS = 'my_orders';
  static const MY_ADDRESSES = 'my_addresses';
  static const MY_PROFILE = 'my_profile';
  static const TOKENS = 'tokens';
  static const CARDS = 'cards';

  static const DEV = 'dev';
  static const PRODUCTION = 'production';
  static const PRODUCT_ID = 'product_id';
  static const DETAIL_ID = 'detail_id';
  static const PRODUCTS = 'products';
  static const USERS = 'users';
  static const PRODUCT_DETAILS = 'product_details';

  Stream<QuerySnapshot> get getAddresses => Firestore.instance
      .collection(DEV)
      .document(USERS)
      .collection(Prefs.fid)
      .document(Constants.USER_DATA)
      .collection(ADDRESSES)
      .snapshots();

  Stream<QuerySnapshot> getProductAllProductsOfCategory(String category) => Firestore.instance
      .collection(DEV)
      .document(PRODUCTS)
      .collection(category)
      .snapshots();

  Stream<QuerySnapshot> getProductAboveIdOfCategory(String category, String id) =>
      Firestore.instance
          .collection(DEV)
          .document(PRODUCTS)
          .collection(category)
          .where('id', isGreaterThan: id)
          .snapshots();

  get getWishlist => Firestore.instance
      .collection(DEV)
      .document(USERS)
      .collection(Prefs.fid)
      .document(Constants.USER_DATA)
      .collection(Constants.WISHLIST)
      .snapshots();

  get getCart => Firestore.instance
      .collection(DEV)
      .document(USERS)
      .collection(Prefs.fid)
      .document(Constants.USER_DATA)
      .collection(Constants.CART)
      .snapshots();

  get getProductId =>
      Firestore.instance.collection(DEV).document(PRODUCT_ID).get();

  Stream<DocumentSnapshot> getTShirtById(String id) {
    Stream<DocumentSnapshot> snapshot = Firestore.instance
        .collection(DEV)
        .document(PRODUCTS)
        .collection('T- Shirt')
        .document(id)
        .snapshots();

    return snapshot;
  }

  Stream<QuerySnapshot> get getOrders => Firestore.instance
      .collection(DEV)
      .document(USERS)
      .collection(Prefs.fid)
      .document(Constants.USER_DATA)
      .collection(ORDERS)
      .snapshots();

  void addAddress({SingleAddress address, BoolListener listener}) {
    if (address.id == null)
      address.id = Firestore.instance.collection(USERS).document().documentID;

    if (address.id != null && Prefs.fid != null)
      Firestore.instance
          .collection(DEV)
          .document(USERS)
          .collection(Prefs.fid)
          .document(Constants.USER_DATA)
          .collection(ADDRESSES)
          .document(address.id)
          .setData(address.toJson())
          .then((data) => listener.success(true))
          .catchError((error) => listener.success(false));
  }

  void updateProfile(Profile profile, BoolListener listener) {
    if (Prefs.fid != null)
      Firestore.instance
          .collection(DEV)
          .document(USERS)
          .collection(Prefs.fid)
          .document(PROFILE)
          .setData(profile.toJson())
          .then((data) => listener.success(true))
          .catchError((error) => listener.success(false));
  }

  void addStripeCard(String token) {
    Map<String, Object> map = Map();
    map['tokenId'] = token;
    Firestore.instance
        .collection(DEV)
        .document(USERS)
        .collection(Prefs.fid)
        .document(CARDS)
        .collection(TOKENS)
        .add(map);
  }
}
