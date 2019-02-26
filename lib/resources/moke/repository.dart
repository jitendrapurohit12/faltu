import 'package:faltu/models/moke/address_unit.dart';
import 'package:faltu/models/moke/order_unit.dart';
import 'package:faltu/models/moke/wearable_unit.dart';
import 'package:faltu/resources/moke/api_provider.dart';

class Repository {
  ApiProvider _provider = ApiProvider();

  Future<WearableUnit> getWearableList() => _provider.getWearableList();

  Future<WearableUnit> getCartWearableList() => _provider.getCartWearableList();

  Future<AddressUnit> getAddressList() => _provider.getAddressList();

  Future<WearableUnit> getWishlist() => _provider.getWishlist();

  Future<OrderUnit> getOrderList() => _provider.getOrderList();
}
