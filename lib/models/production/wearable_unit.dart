import 'package:faltu/constants/constants.dart' as Constant;
import 'package:faltu/models/individual/single_wearable.dart';

class WearableUnit {
  List<SingleWearable> wearableList;
  int length;

  WearableUnit(this.wearableList);

  WearableUnit.fromJson(Map<String, dynamic> json) {
    if (json[Constant.Constants.WEARABLE_WEARABLES] != null) {
      wearableList = new List<SingleWearable>();
      json[Constant.Constants.WEARABLE_WEARABLES].forEach((v) {
        wearableList.add(new SingleWearable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wearableList != null) {
      data[Constant.Constants.WEARABLE_WEARABLES] =
          this.wearableList.map((v) => v.toJson()).toList();
    }
    length = data.length;
    return data;
  }
}