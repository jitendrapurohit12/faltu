import 'package:faltu/constants/constants.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:faltu/models/individual/single_address.dart';
import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/ui/components/cart_list_ui.dart';
import 'package:faltu/utils/method_helper.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class CheckoutSummary extends StatelessWidget {
  final List<IndividualProduct> list;
  final SingleAddress address;

  const CheckoutSummary({Key key, this.list, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.ORDER_SUMMARY),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UIHelper.getTotalPriceLayout(
                      list.length, getTotalAmount())),
              CartListUI(null, list,false),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: UIHelper.customContainerDecoration(
                      Colors.white, Colors.black, 1.0, 4.0),
                  child: getTextColumn(address),
                ),
              ),
              UIHelper.getOrderSummary(getTotalAmount(), 0),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                    onPressed: () =>
                        Navigation.payments(context, getTotalAmount()),
                    color: Colors.black,
                    splashColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: UIHelper.rowWithTextAndIcon(
                          title: Constants.CONTINUE,
                          icon: Icons.arrow_forward,
                          color: Colors.white),
                    )),
              ),
            ],
          ),
        ));
  }

  double getTotalAmount() {
    double totalPrice = 0;
    list.forEach((product) {
      int price = int.parse(product.price);
      int discount = int.parse(product.discount ?? 0);
      totalPrice += MethodHelper.calculateDiscountedPrice(price, discount);
    });
    return totalPrice;
  }

  Widget getTextColumn(SingleAddress unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          unit.name,
          style: TextStyle(
              fontSize: 16.0,
              color: Colors.black54,
              fontWeight: FontWeight.w500),
        ),
        Text(unit.address),
        SizedBox(height: 24.0),
        Text('${unit.city}, ${unit.pin}'),
        Text('Contact Number: ${unit.phone}'),
        unit.altPhone != null
            ? Text('Alternate Number: ${unit.altPhone}')
            : null,
        SizedBox(height: 16.0),
        Chip(
          label: Text(
            unit.type,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        )
      ],
    );
  }
}
