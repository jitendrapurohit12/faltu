import 'package:faltu/bloc/bloc_provider.dart';
import 'package:faltu/bloc/orders_bloc.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/ui/components/order_list_ui.dart';
import 'package:faltu/utils/ly_appbar.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {

  @override
  MyOrdersState createState() {
    return new MyOrdersState();
  }
}

class MyOrdersState extends State<MyOrders> {

  OrdersBloc _orderBloc;

  @override
  void initState() {
    _orderBloc = OrdersBloc();
    super.initState();
  }

  @override
  void dispose() {
    _orderBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.appbar(context, Constants.MY_ORDERS, false),
      body: Container(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: _orderBloc.orderStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return OrderListUI(snapshot.data.documents);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
