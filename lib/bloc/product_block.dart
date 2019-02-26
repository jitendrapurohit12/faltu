import 'dart:async';

import 'package:faltu/bloc/bloc_provider.dart';
import 'package:faltu/firebase_services/firebase_services.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:faltu/sqflite/product_database_helper.dart';

class ProductBloc implements BlocBase {
  //controllers
  StreamController<List<IndividualProduct>> productController =
      StreamController<List<IndividualProduct>>();

  //stream and sink
  StreamSink<List<IndividualProduct>> get productSink => productController.sink;

  Stream<List<IndividualProduct>> get productStream => productController.stream;

  ProductBloc(String type, String category, String gender) {
    getProducts(type, category, gender);
  }

  @override
  void dispose() {
    productController.close();
  }

  void getProducts(String type, String category, String gender) async {
    List<IndividualProduct> list =
        await ProductDatabaseHelper().getProductList(type: type, category: category, gender : gender);
    productSink.add(list);
  }
}
