import 'package:faltu/firebase_services/firestore_refs.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:faltu/models/individual/product_details.dart';
import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/utils/method_helper.dart';
import 'package:flutter/cupertino.dart';

class NavigationHelper{
  static void fetchDetailsAsnLaunchDetailsPage(BuildContext context, IndividualProduct product) {
    FirestoreRefs.getProductDetailsRef(product.category,product.detailsId).listen((snapshot){
      Navigation.wearableUnitDetails(context, MethodHelper.getProductCombinedModel(product,ProductDetails.fromJson(snapshot.data)));
    });
  }
}