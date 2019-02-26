import 'package:faltu/constants/constants.dart';
import 'package:faltu/models/individual/single_wearable.dart';

class WearableUnit {
  List<SingleWearable> wearableList;
  int length;

  WearableUnit(this.wearableList);

  WearableUnit.fromJson() {
    wearableList = new List<SingleWearable>();
    List<String> images = List();
    images.add(
        'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1');
    images.add(
        'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1');
    images.add(
        'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1');
    images.add(
        'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1');
    images.add(
        'https://i1.wp.com/www.mansworldindia.com/wp-content/uploads/2017/07/Ranveer-Singh-Fan.jpg?fit=1200%2C720&ssl=1');

    List<String> size = List();
    size.add('S');
    size.add('M');
    size.add('L');
    size.add('XL');
    size.add('XXL');

    List<int> colors = List();
    colors.add(0xff000000);
    colors.add(0xffff00ff);
    colors.add(0xff00ffff);
    colors.add(0xff0000ff);
    colors.add(0xffffff00);

    for (int i = 0; i < 100; i++) {
      wearableList.add(SingleWearable(
          i,
          'very long name for the wearable',
          '500',
          '20',
          't-shirt',
          'male',
          'arrived',
          'cotton',
          'cashback info',
          'return policy',
          images,
          size,
          colors,
          0xff0000ff,
          'Not Black'));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wearableList != null) {
      data[Constants.WEARABLE_WEARABLES] =
          this.wearableList.map((v) => v.toJson()).toList();
    }
    length = data.length;
    return data;
  }
}
