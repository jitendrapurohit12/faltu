import 'package:faltu/models/moke/address_unit.dart';
import 'package:faltu/models/moke/order_unit.dart';
import 'package:rxdart/rxdart.dart';
import 'package:faltu/resources/moke/repository.dart';
import 'package:faltu/models/moke/wearable_unit.dart';

class FeedsBloc {
  final _repository = Repository();
  final _wearableFetcher = PublishSubject<WearableUnit>();
  final _cartFetcher = PublishSubject<WearableUnit>();
  final _wishlistFetcher = PublishSubject<WearableUnit>();
  final _addressFetcher = PublishSubject<AddressUnit>();
  final _orderFetcher = PublishSubject<OrderUnit>();

  Observable<WearableUnit> get allWearables => _wearableFetcher.stream;

  Observable<WearableUnit> get cartWearables => _cartFetcher.stream;

  Observable<WearableUnit> get wishlist => _wishlistFetcher.stream;

  Observable<AddressUnit> get allAddresses => _addressFetcher.stream;

  Observable<OrderUnit> get orderList => _orderFetcher.stream;

  fetchAllWearables() async {
    WearableUnit unit = await _repository.getWearableList();
    _wearableFetcher.sink.add(unit);
  }

  fetchAllCartWearables() async {
    WearableUnit unit = await _repository.getCartWearableList();
    _cartFetcher.sink.add(unit);
  }

  fetchWishlist() async {
    WearableUnit unit = await _repository.getWishlist();
    _wishlistFetcher.sink.add(unit);
  }

  fetchAllAddresses() async {
    AddressUnit unit = await _repository.getAddressList();
    _addressFetcher.sink.add(unit);
  }

  fetchOrders() async {
    OrderUnit unit = await _repository.getOrderList();
    _orderFetcher.sink.add(unit);
  }

  dispose() {
    _wearableFetcher?.close();
    _cartFetcher?.close();
    _addressFetcher?.close();
    _wishlistFetcher?.close();
    _orderFetcher?.close();
  }

  static FeedsBloc bloc = FeedsBloc();
}
