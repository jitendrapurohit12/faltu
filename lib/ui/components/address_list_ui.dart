import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/listeners/confirmation_listener.dart';
import 'package:faltu/models/individual/single_address.dart';
import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class AddressListUI extends StatefulWidget {
  final List<DocumentSnapshot> _snapshotList;

  const AddressListUI(this._snapshotList);

  @override
  _AddressListUIState createState() => _AddressListUIState();
}

class _AddressListUIState extends State<AddressListUI>
    implements ConfirmationListener {
  List<SingleAddress> addressList = List();

  @override
  void initState() {
    super.initState();

    widget._snapshotList.forEach((snapshot) {
      addressList.add(SingleAddress.fromJson(snapshot.data));
    });
  }

  @override
  void didUpdateWidget(AddressListUI oldWidget) {
    super.didUpdateWidget(oldWidget);
    addressList.clear();
    widget._snapshotList.forEach((snapshot) {
      if (snapshot != null)
        addressList.add(SingleAddress.fromJson(snapshot.data));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: addressList != null ? addressList.length : 0,
            itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: UIHelper.customContainerDecoration(
                        Colors.white, Colors.black, 1.0, 4.0),
                    child: Stack(
                      children: <Widget>[
                        getTextColumn(addressList[index]),
                        Positioned(
                            bottom: 4.0,
                            right: 48.0,
                            child: IconButton(
                                icon: Icon(Icons.edit, color: Colors.black),
                                onPressed: () => Navigation.newAddress(
                                    context, addressList[index]))),
                        Positioned(
                            bottom: 4.0,
                            right: 0.0,
                            child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.black),
                                onPressed: () {
                                  UIHelper.showConfirmationDialog(
                                      context,
                                      Constants.ADDRESS_DELETE_DIALOG,
                                      index,
                                      Constants.DELETE,
                                      this);
                                }))
                      ],
                    ),
                  ),
                )));
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

  @override
  void success(int index) {
    setState(() {
      addressList.removeAt(index);
    });
  }
}
