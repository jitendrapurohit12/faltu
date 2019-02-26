import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/shared_preferences/prefs.dart';

class FirestoreRefs {
  static DocumentReference get detailsIdRef => Firestore.instance
      .collection(Constants.DEV)
      .document(Constants.DETAIL_ID);

  static Stream<DocumentSnapshot> getProductDetailsRef(
          String category, String id) =>
      Firestore.instance
          .collection(Constants.DEV)
          .document(Constants.PRODUCT_DETAILS)
          .collection(category)
          .document(id)
          .snapshots();

  static CollectionReference get wishlistRef => Firestore.instance
      .collection(Constants.DEV)
      .document(Constants.USERS)
      .collection(Prefs.fid)
      .document(Constants.USER_DATA)
      .collection(Constants.WISHLIST);

  static CollectionReference get cartRef => Firestore.instance
      .collection(Constants.DEV)
      .document(Constants.USERS)
      .collection(Prefs.fid)
      .document(Constants.USER_DATA)
      .collection(Constants.CART);
}
