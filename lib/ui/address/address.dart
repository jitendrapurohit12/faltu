import 'package:faltu/bloc/AddressBloc.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/ui/components/address_list_ui.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {

  AddressBloc _addressBloc;

  @override
  void initState() {
    _addressBloc = AddressBloc();
    super.initState();
  }

  @override
  void dispose() {
    _addressBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.addressAppbar(context, Constants.MY_ADDRESS),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: _addressBloc.addressStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AddressListUI(snapshot.data.documents);
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
        )
      ),
    );
  }

  void createSnackBar(String message,BuildContext context) {
    final snackBar = new SnackBar(content: new Text(message),
        backgroundColor: Colors.red);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    Scaffold.of(context).showSnackBar(snackBar);
  }

}
