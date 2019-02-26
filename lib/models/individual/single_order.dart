import 'package:faltu/constants/constants.dart';

class SingleOrder {
  String _name, _id, _productId, _price, _size, _address, _image, _status;
  int _date;


  SingleOrder(this._name, this._id, this._productId, this._price, this._size,
      this._address, this._image, this._status, this._date);

  SingleOrder.fromJson(Map<String, dynamic> json) {
    _name = json[Constants.ORDER_NAME];
    _id = json[Constants.ORDER_ID];
    _address = json[Constants.ORDER_ADDRESS];
    _productId = json[Constants.ORDER_PRODUCT_ID];
    _price = json[Constants.ORDER_PRICE];
    _size = json[Constants.ORDER_SIZE];
    _image = json[Constants.ORDER_IMAGE];
    _status = json[Constants.ORDER_STATUS];
    _date = json[Constants.ORDER_DATE];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data[Constants.ORDER_NAME] = _name;
    data[Constants.ORDER_ID] = _id;
    data[Constants.ORDER_ADDRESS] = _address;
    data[Constants.ORDER_PRODUCT_ID] = _productId;
    data[Constants.ORDER_PRICE] = _price;
    data[Constants.ORDER_SIZE] = _size;
    data[Constants.ORDER_IMAGE] = _image;
    data[Constants.ORDER_STATUS] = _status;
    data[Constants.ORDER_DATE] = _date;
    return data;
  }

  int get date => _date;

  get image => _image;

  get address => _address;

  get size => _size;

  get price => _price;

  get productId => _productId;

  get id => _id;

  String get name => _name;

  get status => _status;
}
