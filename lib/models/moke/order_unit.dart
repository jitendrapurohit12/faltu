import 'package:faltu/constants/constants.dart';
import 'package:faltu/models/individual/single_address.dart';
import 'package:faltu/models/individual/single_order.dart';

class OrderUnit {
  List<SingleOrder> orderList;
  int length;

  OrderUnit(this.orderList);

  OrderUnit.fromJson() {
    orderList = List<SingleOrder>();

    var order = SingleOrder(
        'This is Product Name',
        '123123123',
        '121212121',
        '399',
        'Small',
        'This is a long address',
        'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1',
        '4',
        DateTime.now().millisecond);

    for (int i = 0; i < 15; i++) {
      orderList.add(order);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map();
    if (orderList != null) {
      data[Constants.ORDER_ORDERS] = orderList.map((unit) => unit.toJson()).toList();
    }
    length = orderList.length;
    return data;
  }
}
