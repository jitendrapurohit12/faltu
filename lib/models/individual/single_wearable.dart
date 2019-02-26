import 'package:faltu/constants/constants.dart';

class SingleWearable {
  String name, price, discount, type, gender, fabricType, status;
  String cashBackInfo, returnPolicy, colorName;
  List<String> images, sizeOptions;
  List<int> colors;
  int color, id;

  SingleWearable(
      this.id,
      this.name,
      this.price,
      this.discount,
      this.type,
      this.gender,
      this.fabricType,
      this.status,
      this.cashBackInfo,
      this.returnPolicy,
      this.images,
      this.sizeOptions,
      this.colors,
      this.color,
      this.colorName);

  SingleWearable.fromJson(Map<String, dynamic> json) {
    id = json[Constants.WEARABLE_ID];
    name = json[Constants.WEARABLE_NAME];
    price = json[Constants.WEARABLE_PRICE];
    discount = json[Constants.WEARABLE_DISCOUNT];
    type = json[Constants.WEARABLE_TYPE];
    gender = json[Constants.WEARABLE_GENDER];
    fabricType = json[Constants.WEARABLE_FABRIC];
    status = json[Constants.WEARABLE_STATUS];
    cashBackInfo = json[Constants.WEARABLE_CASHBACK];
    color = json[Constants.WEARABLE_COLOR];
    colorName = json[Constants.WEARABLE_COLOR_NAME];
    images = json[Constants.WEARABLE_IMAGES]?.cast<String>();
    sizeOptions = json[Constants.WEARABLE_SIZE]?.cast<String>();
    colors = json[Constants.WEARABLE_COLORS]?.cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[Constants.WEARABLE_ID] = this.id;
    data[Constants.WEARABLE_NAME] = this.name;
    data[Constants.WEARABLE_PRICE] = this.price;
    data[Constants.WEARABLE_DISCOUNT] = this.discount;
    data[Constants.WEARABLE_TYPE] = this.type;
    data[Constants.WEARABLE_GENDER] = this.gender;
    data[Constants.WEARABLE_FABRIC] = this.fabricType;
    data[Constants.WEARABLE_STATUS] = this.status;
    data[Constants.WEARABLE_CASHBACK] = this.cashBackInfo;
    data[Constants.WEARABLE_IMAGES] = this.images;
    data[Constants.WEARABLE_SIZE] = this.sizeOptions;
    data[Constants.WEARABLE_COLORS] = this.colors;
    data[Constants.WEARABLE_COLOR] = this.color;
    data[Constants.WEARABLE_COLOR_NAME] = this.colorName;
    return data;
  }
}
