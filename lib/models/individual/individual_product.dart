import 'package:faltu/constants/constants.dart';

class IndividualProduct {
  String id;
  String name;
  String color;
  String price;
  String discount;
  String type;
  String category;
  String units;
  List images;
  List size;
  String detailsId;

  IndividualProduct(
      {this.id,
        this.name,
        this.color,
        this.price,
        this.discount,
        this.type,
        this.category,
        this.units,
        this.images,
        this.size,
        this.detailsId});

  static IndividualProduct fromJson(Map<String, dynamic> json) {
    return IndividualProduct(
        id: json['id'],
        name: json['name'],
        color: json['color'],
        price: json['price'],
        discount: json['discount'],
        type: json['type'],
        category: json['category'],
        units: json['units'],
        images: json['images'].cast<String>(),
        size: json['size'].cast<String>(),
        detailsId: json['details_id']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'color': color,
    'price': price,
    'discount': discount,
    'type': type,
    'category': category,
    'units': units,
    'images': images,
    'size': size,
    'details_id': detailsId
  };

  static Map<String, dynamic> getProductForSqFlite(Map<String, dynamic> map) {
    IndividualProduct product = IndividualProduct.fromJson(map);
    StringBuffer images = StringBuffer();
    StringBuffer size = StringBuffer();
    images.writeAll(product.images, Constants.FALTU_SEPRATOR);
    size.writeAll(product.size, Constants.FALTU_SEPRATOR);

    map['images'] = images.toString();
    map['size'] = size.toString();

    return map;
  }

  static IndividualProduct getProductFromSqlite(Map<String, dynamic> map) =>
      IndividualProduct(
          id: map['id'],
          name: map['name'],
          color: map['color'],
          price: map['price'],
          discount: map['discount'],
          type: map['type'],
          category: map['category'],
          units: map['units'],
          images: map['images'].toString().split(Constants.FALTU_SEPRATOR),
          size: map['size'].toString().split(Constants.FALTU_SEPRATOR),
          detailsId: map['details_id']);
}
