import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/firebase_services/firebase_services.dart';
import 'package:faltu/sqflite/product_database_helper.dart';
import 'package:faltu/utils/method_helper.dart';

class FirestoreHelper {
  FirebaseService _firebaseService;

  FirestoreHelper() {
    _firebaseService = FirebaseService();
    updateProducts();
    ProductDatabaseHelper().getProductList();
  }

  void updateProducts() async {
    DocumentSnapshot snapshot = await _firebaseService.getProductId;

    if (snapshot.exists) {
      var id = int.parse(snapshot['id']);
      int maxIdInSqlite = await ProductDatabaseHelper().checkProductRefresh(id);

      if (maxIdInSqlite == 0) {
        getAllProductsFirestore();
      } else if (maxIdInSqlite > 0 && id - 1 > maxIdInSqlite) {
        getAllProductsAboveIdFromFirestore(maxIdInSqlite.toString());
      }
    }
  }

  void getAllProductsAboveIdFromFirestore(String maxId) {
    MethodHelper.getCategoryList().forEach((category) {
      FirebaseService()
          .getProductAboveIdOfCategory(category, maxId.toString())
          .listen((snapshot) {
        ProductDatabaseHelper().insertProducts(snapshot);
      });
    });
  }

  void getAllProductsFirestore() {
    MethodHelper.getCategoryList().forEach((category) {
      FirebaseService()
          .getProductAllProductsOfCategory(MethodHelper.getCategoryList()[0])
          .listen((snapshot) {
        print('snapshot length = ${snapshot.documents.length}');
        ProductDatabaseHelper().insertProducts(snapshot);
      });
    });
  }
}
