import 'package:faltu/constants/constants.dart';
import 'package:faltu/firebase_services/firebase_services.dart';
import 'package:faltu/utils/ly_appbar.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class Payments extends StatefulWidget {

  final double amount;

  const Payments({Key key, this.amount}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {

  @override
  void initState() {
    super.initState();

    StripeSource.setPublishableKey('pk_test_3UNX1j9BMbnBwyo965Rcidjo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.appbar(context, Constants.PAYMENTS, false),
      body: Container(
        child: Center(
          child: MaterialButton(onPressed: (){
            StripeSource.addSource().then((token){
              print(token);
              FirebaseService().addStripeCard(token);
            });
          },
          child: Text('Add Card'),
          color: Colors.amber),
        ),
      ),
    );
  }
}
