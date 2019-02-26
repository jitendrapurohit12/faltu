import 'package:faltu/bloc/address_text_bloc.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/firebase_services/firebase_services.dart';
import 'package:faltu/listeners/bool_listener.dart';
import 'package:faltu/models/individual/single_address.dart';
import 'package:faltu/utils/ly_appbar.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class NewAddress extends StatefulWidget {
  final SingleAddress unit;

  const NewAddress(this.unit);

  @override
  _NewAddressState createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> implements BoolListener{
  TextInputType numberType =
      TextInputType.numberWithOptions(decimal: false, signed: false);
  TextInputType multiLine = TextInputType.multiline;

  TextEditingController nameController,
      phoneController,
      altPhoneController,
      pinController,
      addressController,
      localityController,
      landmarkController,
      cityController,
      stateController;

  AddressTextBloc _addressTextBloc;

  String _addressType = Constants.HOME;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.unit?.name);
    phoneController = TextEditingController(text: widget.unit?.phone);
    altPhoneController = TextEditingController(text: widget.unit?.altPhone);
    pinController = TextEditingController(text: widget.unit?.pin);
    addressController = TextEditingController(text: widget.unit?.address);
    localityController = TextEditingController(text: widget.unit?.locality);
    landmarkController = TextEditingController(text: widget.unit?.landmark);
    cityController = TextEditingController(text: widget.unit?.city);
    stateController = TextEditingController(text: widget.unit?.state);

    _addressTextBloc = AddressTextBloc();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    altPhoneController.dispose();
    pinController.dispose();
    addressController.dispose();
    localityController.dispose();
    landmarkController.dispose();
    cityController.dispose();
    stateController.dispose();

    _addressTextBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.appbar(context,
          widget.unit != null ? 'Update Address' : 'New Address', false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Receiver\'s info',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              SizedBox(height: 16.0),
              UIHelper.getStringStreamBuilderWithoutBorder(
                  context,
                  _addressTextBloc.name,
                  _addressTextBloc.nameChanged,
                  Constants.HINT_NAME,
                  nameController,
                  null,
                  40),
              SizedBox(height: 16.0),
              UIHelper.getStringStreamBuilderWithoutBorder(
                  context,
                  _addressTextBloc.primaryMobile,
                  _addressTextBloc.primaryMobileChanged,
                  Constants.HINT_PHONE,
                  phoneController,
                  numberType,
                  10),
              UIHelper.getStringStreamBuilderWithoutBorder(
                  context,
                  _addressTextBloc.alternateMobile,
                  _addressTextBloc.alternateMobileChanged,
                  Constants.HINT_ALT_PHONE,
                  altPhoneController,
                  numberType,
                  10),
              UIHelper.getStringStreamBuilderWithoutBorder(
                  context,
                  _addressTextBloc.pincode,
                  _addressTextBloc.pincodeChanged,
                  Constants.HINT_PIN,
                  pinController,
                  numberType,
                  6),
              SizedBox(height: 16.0),
              Text(
                Constants.HINT_ADDRESS,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              SizedBox(height: 16.0),
              UIHelper.getStringStreamBuilderWithoutBorder(
                  context,
                  _addressTextBloc.address,
                  _addressTextBloc.addressChanged,
                  Constants.HINT_ADDRESS,
                  addressController,
                  null,
                  80),
              SizedBox(height: 16.0),
              UIHelper.getStringStreamBuilderWithoutBorder(
                  context,
                  _addressTextBloc.locality,
                  _addressTextBloc.localityChanged,
                  Constants.HINT_LOCALITY,
                  localityController,
                  null,
                  40),
              SizedBox(height: 16.0),
              UIHelper.textField(
                  null, null, Constants.HINT_LANDMARK, landmarkController),
              SizedBox(height: 16.0),
              UIHelper.getStringStreamBuilderWithoutBorder(
                  context,
                  _addressTextBloc.city,
                  _addressTextBloc.cityChanged,
                  Constants.HINT_CITY,
                  cityController,
                  null,
                  40),
              SizedBox(height: 16.0),
              UIHelper.getStringStreamBuilderWithoutBorder(
                  context,
                  _addressTextBloc.state,
                  _addressTextBloc.stateChanged,
                  Constants.HINT_STATE,
                  stateController,
                  null,
                  40),
              SizedBox(height: 16.0),
              addressTypeSelector(),
              SizedBox(height: 56.0),
              SizedBox(
                width: double.infinity,
                child: StreamBuilder<bool>(
                  stream: _addressTextBloc.profileCheck,
                  builder: (context, snapshot) => RaisedButton(
                    onPressed: snapshot.hasData ? () => saveAddress() : null,
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Text(
                      widget.unit != null ? 'Update' : 'Add',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    color: Colors.black,
                    splashColor: Colors.white,
                  ),
                )
              ),
              SizedBox(height: 24.0)
            ],
          ),
        ),
      ),
    );
  }

  Widget addressTypeSelector() {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => setAddressType(Constants.HOME),
            child: Container(
              height: 45.0,
              decoration: UIHelper.customContainerDecoration(
                  Colors.white, getBorderColor(Constants.HOME), 1.0, 8.0),
              child: Center(
                child: Text(Constants.HOME),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setAddressType(Constants.WORK),
            child: Container(
              height: 45.0,
              decoration: UIHelper.customContainerDecoration(
                  Colors.white, getBorderColor(Constants.WORK), 1.0, 8.0),
              child: Center(
                child: Text(Constants.WORK),
              ),
            ),
          ),
        )
      ],
    );
  }

  Color getBorderColor(String gender) {
    Color color = gender == _addressType ? Colors.black : Colors.white;
    return color;
  }

  setAddressType(String addressType) {
    setState(() {
      _addressType = addressType;
    });
  }

  void saveAddress() {
    UIHelper.showProgressDialog(context: context, message: 'Saving Address');
    SingleAddress address = SingleAddress(
        widget.unit?.id,
        nameController.text,
        phoneController.text,
        altPhoneController.text,
        pinController.text,
        addressController.text,
        localityController.text,
        landmarkController.text,
        cityController.text,
        stateController.text,
        _addressType);

    FirebaseService firebaseService = FirebaseService();
    firebaseService.addAddress(address: address);
  }

  @override
  void success(bool result) {
    if (result) {
      Navigator.pop(context);
      Navigator.pop(context);
    } else
      UIHelper.showErrorDialog(context, Constants.ERROR_UPDATE_ADDRESS);
  }
}
