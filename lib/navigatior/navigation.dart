import 'package:faltu/models/individual/combined_product.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:faltu/models/individual/product_details.dart';
import 'package:faltu/models/individual/single_address.dart';
import 'package:faltu/models/individual/single_wearable.dart';
import 'package:faltu/ui/categories/category.dart';
import 'package:faltu/ui/checkout/address_selection.dart';
import 'package:faltu/ui/cart/cart.dart';
import 'package:faltu/ui/checkout/checkout_summary.dart';
import 'package:faltu/ui/components/filter.dart';
import 'package:faltu/ui/dashboard/profile.dart';
import 'package:faltu/ui/first_fragnemt/wearable_unit_details.dart';
import 'package:faltu/ui/home/men_products.dart';
import 'package:faltu/ui/home/home.dart';
import 'package:faltu/ui/home/my_wishlist.dart';
import 'package:faltu/ui/home/second_fragment.dart';
import 'package:faltu/ui/home/women_products.dart';
import 'package:faltu/ui/address/address.dart';
import 'package:faltu/ui/payments/payment_methods.dart';
import 'package:faltu/ui/profile/edit_profile.dart';
import 'package:faltu/ui/address/new_address.dart';
import 'package:faltu/ui/profile/orders.dart';
import 'package:faltu/ui/signin/sign_in.dart';
import 'package:flutter/material.dart';

class Navigation {
  static void signIn(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
        (Route<dynamic> route) => false);
  }

  static void home(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  static void secondFragment(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondFragment()));
  }

  static void women(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ThirdFragment()));
  }

  static void men(BuildContext context, String type, String category) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MenProducts(type: type, category: category)));
  }

  static void cart(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
  }

  static void profile(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyProfile()));
  }

  static void editProfile(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProfile()));
  }

  static void address(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Address()));
  }

  static void category(BuildContext context, String title) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Category(title: title)));
  }

  static void myOrders(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyOrders()));
  }

  static void myWishlist(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyWishlist()));
  }

  static void wearableUnitDetails(
      BuildContext context, CombinedProduct combinedProduct) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WearableUnitDetails(combinedProduct)));
  }

  static void newAddress(BuildContext context, SingleAddress address) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewAddress(address)));
  }

  static void addressSelection(
      BuildContext context, List<IndividualProduct> list) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddressSelection(list: list)));
  }

  static void checkout(BuildContext context, List<IndividualProduct> list,
      SingleAddress address) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CheckoutSummary(list: list, address: address)));
  }

  static void payments(BuildContext context, double amount) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Payments(amount: amount)));
  }

  static dynamic filters(BuildContext context, int type) async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Filters(type)));
  }
}
