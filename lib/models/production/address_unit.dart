import 'package:faltu/constants/constants.dart' as Constant;
import 'package:faltu/models/individual/single_wearable.dart';

class AddressUnit {
  List<SingleWearable> addressList;
  int length;

  AddressUnit(this.addressList);

  AddressUnit.fromJson(Map<String, dynamic> json) {
    if (json[Constant.Constants.ADDRESS_ADDRESSES] != null) {
      addressList = new List<SingleWearable>();
      json[Constant.Constants.ADDRESS_ADDRESSES].forEach((v) {
        addressList.add(new SingleWearable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressList != null) {
      data[Constant.Constants.ADDRESS_ADDRESSES] =
          this.addressList.map((v) => v.toJson()).toList();
    }
    length = data.length;
    return data;
  }
}