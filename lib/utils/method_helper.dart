import 'package:faltu/constants/constants.dart';
import 'package:faltu/firebase_services/firestore_refs.dart';
import 'package:faltu/models/individual/combined_product.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:faltu/models/individual/product_details.dart';
import 'package:flutter/material.dart';

class MethodHelper {
  static double calculateDiscountedPrice(int price, int discount) =>
      (price / 100) * (100 - discount);

  static List<String> getProfileTitleList() {
    var list = ['My Profile', 'My Address', 'My Orders'];
    return list;
  }

  static List<String> getProfileDescriptionList() {
    var list = [
      'Edit personal info, phone number, image.',
      'Edit, add or remove address',
      'View, modify and track orders'
    ];
    return list;
  }

  static List<String> getGenderList() {
    var list = ['Male', 'Female'];
    return list;
  }

  static List<String> getOrderStatusList() {
    var list = ['Confirmed', 'Packed', 'Shipped', 'Delivered'];
    return list;
  }

  static Map<String, Map<Object, bool>> getFilterMap(int type) {
    Map<String, Map<Object, bool>> sortMap = Map();

    switch (type) {
      case Constants.TSHIRT:
        sortMap['Color'] = getColorsList();
        sortMap['Size'] = getSizeList();
        sortMap['Sleeve'] = getSleeveList();
        break;
    }

    return sortMap;
  }

  static Map<int, bool> getColorsList() {
    Map<int, bool> map = Map();
    map[0xFF000000] = false;
    map[0xFFFF0000] = false;
    map[0xFF00FF00] = false;
    map[0xFF0000FF] = false;
    map[0xFFFFFF00] = false;
    map[0xFF00FFFF] = false;
    map[0xFFFF00FF] = false;
    map[0xFFFFffFF] = false;
    return map;
  }

  static Map<String, bool> getSizeList() {
    Map<String, bool> map = Map();
    map[' S '] = false;
    map[' M '] = false;
    map[' L '] = false;
    map[' XL '] = false;
    map['XXL'] = false;
    map['XXL'] = false;
    return map;
  }

  static Map<String, bool> getSleeveList() {
    Map<String, bool> map = Map();
    map['Full'] = false;
    map['Half'] = false;
    return map;
  }

  static List<String> getCategoryList() {
    List<String> list = List();
    list.add('Topwear');
    list.add('Bottomwear');
    list.add('Footwear');
    list.add('Accessories');
    list.add('Mobile Covers');

    return list;
  }

  static List<String> getTypeList(String category) {
    List<String> list = List();
    switch(category){
      case 'Topwear':
        list = getTopWearTypeList();
        break;
      case 'Bottomwear':
        list = getBottomWearTypeList();
        break;
      case 'Footwear':
        list = getFootwearWearTypeList();
        break;
      case 'Accessories':
        list = getAccessoriesTypeList();
        break;
      case 'Mobile Covers':
        list = getAccessoriesTypeList();
        break;
    }
    return list;
  }

  static List<String> getTopWearTypeList() {
    List<String> list = List();
    list.add('T-Shirt');
    list.add('Full Sleeve T-Shirt');
    list.add('Hoodies & Sweatshirts');
    list.add('Plain T-Shirts');
    list.add('Shirts');
    list.add('All');

    return list;
  }

  static List<String> getBottomWearTypeList() {
    List<String> list = List();
    list.add('Joggers');
    list.add('Pants & Trousers');
    list.add('Shorts');
    list.add('All');

    return list;
  }

  static List<String> getFootwearWearTypeList() {
    List<String> list = List();
    list.add('Sliders');
    list.add('All');

    return list;
  }

  static List<String> getAccessoriesTypeList() {
    List<String> list = List();
    list.add('Bags');
    list.add('All');

    return list;
  }


  static int getColorCode(String name) {
    switch (name) {
      case 'White':
        return 0xffffffff;
      case 'Red':
        return 0xffff0000;
      case 'Green':
        return 0xff00ff00;
      case 'Blue':
        return 0xff0000ff;
      case 'Black':
        return 0xff000000;
      default:
        return 0;
    }
  }

  static CombinedProduct getProductCombinedModel(
      IndividualProduct product, ProductDetails details) {
    CombinedProduct combinedProduct = CombinedProduct(
        product.id,
        product.name,
        product.color,
        product.price,
        product.discount,
        product.type,
        product.images,
        product.size,
        product.detailsId,
        details.sleeve,
        details.neck,
        details.design,
        details.ids,
        details.colors,
        details.category);

    return combinedProduct;
  }

  static addToWishlist(BuildContext context, CombinedProduct product) {
    FirestoreRefs.wishlistRef
        .document(product.id)
        .setData(product.individualProduct.toJson())
        .catchError((error) => print(error));
  }

  static addToCart(BuildContext context, CombinedProduct product) {
    FirestoreRefs.cartRef
        .document(product.id)
        .setData(product.individualProduct.toJson())
        .catchError((error) => print(error));
  }

  static removeFromWishlist(BuildContext context, String productId) {
    FirestoreRefs.wishlistRef
        .document(productId)
        .delete()
        .catchError((error) => print(error));
  }

  static removeFromCart(BuildContext context, String productId) {
    FirestoreRefs.cartRef
        .document(productId)
        .delete()
        .catchError((error) => print(error));
  }
}
