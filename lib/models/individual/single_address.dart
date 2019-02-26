import 'package:faltu/constants/constants.dart';

class SingleAddress {
  String _id,
      _name,
      _phone,
      _altPhone,
      _pin,
      _address,
      _locality,
      _landmark,
      _city,
      _state,
      _type;

  SingleAddress(
      this._id,
      this._name,
      this._phone,
      this._altPhone,
      this._pin,
      this._address,
      this._locality,
      this._landmark,
      this._city,
      this._state,
      this._type);

  SingleAddress.fromJson(Map<String, dynamic> json) {
    _id = json[Constants.ID];
    _name = json[Constants.ADDRESS_NAME];
    _phone = json[Constants.ADDRESS_PHONE];
    _altPhone = json[Constants.ADDRESS_ALT_PHONE];
    _pin = json[Constants.ADDRESS_PIN];
    _address = json[Constants.ADDRESS_ADDRESS];
    _locality = json[Constants.ADDRESS_LOCALITY];
    _landmark = json[Constants.ADDRESS_LANDMARK];
    _city = json[Constants.ADDRESS_CITY];
    _state = json[Constants.ADDRESS_STATE];
    _type = json[Constants.ADDRESS_TYPE];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data[Constants.ID] = _id;
    data[Constants.ADDRESS_NAME] = _name;
    data[Constants.ADDRESS_PHONE] = _phone;
    data[Constants.ADDRESS_ALT_PHONE] = _altPhone;
    data[Constants.ADDRESS_PIN] = _pin;
    data[Constants.ADDRESS_ADDRESS] = _address;
    data[Constants.ADDRESS_LOCALITY] = _locality;
    data[Constants.ADDRESS_LANDMARK] = _landmark;
    data[Constants.ADDRESS_CITY] = _city;
    data[Constants.ADDRESS_STATE] = _state;
    data[Constants.ADDRESS_TYPE] = _type;
    return data;
  }

  get id => _id;

  get name => _name;

  get phone => _phone;

  get altPhone => _altPhone;

  get pin => _pin;

  get address => _address;

  get locality => _locality;

  get landmark => _landmark;

  get city => _city;

  get state => _state;

  get type => _type;

  set id(String value) {
    _id = value;
  }


}
