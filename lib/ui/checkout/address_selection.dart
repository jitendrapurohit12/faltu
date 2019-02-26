import 'package:faltu/bloc/AddressBloc.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/listeners/generic_listener.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:faltu/models/individual/single_address.dart';
import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/ui/components/address_selection_ui.dart';
import 'package:faltu/utils/ly_appbar.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class AddressSelection extends StatefulWidget {

  final List<IndividualProduct> list;

  const AddressSelection({Key key, this.list}) : super(key: key);

  @override
  _AddressSelectionState createState() => _AddressSelectionState();
}

class _AddressSelectionState extends State<AddressSelection> implements GenericListener{
  AddressBloc _addressBloc;
  SingleAddress _selectedAddress;

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
        appBar: Appbar.appbar(context, Constants.CHOOSE_ADDRESS, false),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                StreamBuilder(
                    stream: _addressBloc.addressStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return AddressSelectionUI(snapshot.data.documents, this);
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                MaterialButton(
                    onPressed: () => Navigation.checkout(context, widget.list, _selectedAddress),
                    color: Colors.black,
                    splashColor: Colors.white,
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: UIHelper.rowWithTextAndIcon(
                        title: Constants.CONTINUE,
                        icon: Icons.arrow_forward,
                        color: Colors.white)),
                SizedBox(height: 24)
              ],
            )));
  }

  @override
  void data(data) {
    if(data is SingleAddress){
       _selectedAddress = data;
    }
  }
}
