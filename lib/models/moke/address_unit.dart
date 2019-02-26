import 'package:faltu/constants/constants.dart';
import 'package:faltu/models/individual/single_address.dart';

class AddressUnit {
  List<SingleAddress> list;
  int length;

  AddressUnit(this.list);

  AddressUnit.fromJson() {
    list = List<SingleAddress>();

    var address = SingleAddress(
        'Name',
        '7737952957',
        '7737952957',
        '123456',
        'This a long long address',
        'Shilpgram',
        'Udaipur',
        'Udaipur',
        'Rajasthan',
        'Office',null);

    for (int i = 0; i < 5; i++) {
      list.add(address);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    if (list != null) {
      data[Constants.ADDRESS_ADDRESSES] =
          list.map((unit) => unit.toJson()).toList();
    }
    length = list.length;
    return data;
  }
}
