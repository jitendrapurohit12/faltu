import 'package:faltu/models/moke/address_unit.dart';
import 'package:faltu/models/moke/order_unit.dart';
import 'package:faltu/models/moke/wearable_unit.dart';

class ApiProvider {
  final url = 'url will appear here!!!';

  Future<WearableUnit> getWearableList() async {
    return WearableUnit.fromJson();
  }

  Future<WearableUnit> getCartWearableList() async {
    return WearableUnit.fromJson();
  }

  Future<AddressUnit> getAddressList() async {
    return AddressUnit.fromJson();
  }

  Future<WearableUnit> getWishlist() async {
    return WearableUnit.fromJson();
  }

  Future<OrderUnit> getOrderList() async {
    return OrderUnit.fromJson();
  }
}
