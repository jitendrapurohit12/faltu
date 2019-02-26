import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/models/individual/single_order.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderListUI extends StatefulWidget {
  final List<DocumentSnapshot> _snapshotList;

  OrderListUI(this._snapshotList);

  @override
  _OrderListUIState createState() => _OrderListUIState();
}

class _OrderListUIState extends State<OrderListUI> {
  List<SingleOrder> orderList = List();

  @override
  void initState() {
    super.initState();

    widget._snapshotList.forEach((snapshot){
      orderList.add(SingleOrder.fromJson(snapshot.data));
    });
  }


  @override
  void didUpdateWidget(OrderListUI oldWidget) {
    super.didUpdateWidget(oldWidget);
    orderList.clear();
    widget._snapshotList.forEach((snapshot){
      if(snapshot != null)
        orderList.add(SingleOrder.fromJson(snapshot.data));
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.width;
    return Expanded(
        child: ListView.builder(
            itemCount: orderList.length,
            itemBuilder: (context, index) => GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                    child: Container(
                      height: height / 1.5,
                      decoration: UIHelper.customContainerDecorationWithImage(
                          Colors.white70,
                          Colors.black,
                          1.0,
                          6.0,
                          orderList[index].image),
                      child: getOrderDetails(
                          orderList[index], height),
                    ),
                  ),
                )));
  }

  Widget getOrderDetails(SingleOrder order, double width) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              order.name,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(text: UIHelper.getTextSpan('Order Id ', order.id)),
              RichText(
                  text: UIHelper.getTextSpan(
                      'Order Date ',
                      DateFormat.yMMMMd("en_US").format(
                          DateTime.fromMillisecondsSinceEpoch(order.date)))),
              RichText(text: UIHelper.getTextSpan('Size ', order.size)),
            ],
          ),
          getStatusLayout(order, width),
          Padding(
              padding: EdgeInsets.only(bottom: 8.0), child: getButtonLayout())
        ],
      ),
    );
  }

  getButtonLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FlatButton(
            onPressed: () {},
            child: Text('Return',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0))),
        VerticalDivider(
          color: Colors.black,
        ),
        FlatButton(
            onPressed: () {},
            child: Text('Info',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)))
      ],
    );
  }

  getStatusLayout(SingleOrder order, double width) {
    return Column(
      children: <Widget>[
        UIHelper.orderStatusUI(order.status, width),
        SizedBox(height: 8.0),
        UIHelper.orderStatusTextUI(width),
      ],
    );
  }
}
