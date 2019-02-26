import 'package:faltu/constants/constants.dart' as Constant;
import 'package:faltu/models/individual/single_order.dart';
import 'package:faltu/models/individual/single_wearable.dart';

class OrderUnit {
  List<SingleOrder> orderList;
  int length;

  OrderUnit(this.orderList);

  OrderUnit.fromJson(Map<String, dynamic> json) {
    if (json[Constant.Constants.ORDER_ORDERS] != null) {
      orderList = new List<SingleOrder>();
      json[Constant.Constants.ORDER_ORDERS].forEach((v) {
        orderList.add(new SingleOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderList != null) {
      data[Constant.Constants.ORDER_ORDERS] =
          this.orderList.map((v) => v.toJson()).toList();
    }
    length = data.length;
    return data;
  }
}