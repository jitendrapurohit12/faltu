import 'package:faltu/models/individual/individual_product.dart';

class CombinedProduct {
  String id;
  String name;
  String color;
  String price;
  String discount;
  String type;
  List images;
  List size;
  String detailsId;
  String sleeve;
  String neck;
  String design;
  List<String> ids;
  List<String> colors;
  String category;

  CombinedProduct(
      this.id,
      this.name,
      this.color,
      this.price,
      this.discount,
      this.type,
      this.images,
      this.size,
      this.detailsId,
      this.sleeve,
      this.neck,
      this.design,
      this.ids,
      this.colors,
      this.category);

  IndividualProduct get individualProduct => IndividualProduct(
      id: id,
      name: name,
      color: color,
      price: price,
      discount: discount,
      type: type,
      images: images,
      size: size,
      detailsId: detailsId);
}
