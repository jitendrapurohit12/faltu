class ProductDetails {
  String sleeve;
  String neck;
  String design;
  List<String> ids;
  List<String> colors;
  String category;
  String type;

  ProductDetails({
    this.sleeve,
    this.neck,
    this.design,
    this.ids,
    this.colors,
    this.category,
    this.type,
  });

  static ProductDetails fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      sleeve: json['sleeve'],
      neck: json['neck'],
      design: json['design'],
      ids: json['ids'].cast<String>(),
      colors: json['colors'].cast<String>(),
      category: json['category'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
    'sleeve': sleeve,
    'neck': neck,
    'design': design,
    'ids': ids,
    'colors': colors,
    'category': category,
    'type': type,
  };
}
