import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/utils/method_helper.dart';
import 'package:faltu/utils/navigation_helper.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class WearableListUI extends StatefulWidget {
  final List<IndividualProduct> _snapshotList;
  final Map<String, Map<Object, bool>> _sortMap;

  WearableListUI(this._snapshotList, this._sortMap);

  @override
  WearableListUIState createState() {
    return new WearableListUIState();
  }
}

class WearableListUIState extends State<WearableListUI> {
  final PageController _controller = PageController();

  List<IndividualProduct> list = List();

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  void didUpdateWidget(WearableListUI oldList) {
    if (widget._sortMap != null) getList();
    super.didUpdateWidget(oldList);
  }

  @override
  Widget build(BuildContext context) {
    final height = 120.0;
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () => NavigationHelper.fetchDetailsAsnLaunchDetailsPage(context,list[index]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              child: Container(
                height: height,
                decoration: UIHelper.customContainerDecoration(
                    Colors.white70, Colors.black, 1.0, 6.0),
                child: Row(
                  children: <Widget>[
                    UIHelper.getPager(context, int.parse(list[index].id),
                        list[index].images, _controller, height, height, true),
                    UIHelper.listUnitDetails(list[index])
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void getList() {
    /*if(widget._sortMap == null)*/
    list.addAll(widget._snapshotList);
    /*else{
      list.clear();
      widget._snapshot.data.wearableList.forEach((wearable){
        bool add;
        widget._sortMap.forEach((key, value){
          value.forEach((key2, value2){
            if(value2){
              print(key);
              switch(key){
                case 'Color':
                  if(wearable.color == key2)
                    add = true;
                  else add = false;
                  break;
                case 'Size':
                  String size = key2;
                  size = size.trim();
                  if(wearable.sizeOptions.contains(size))
                    add = true;
                  else add = false;
                  break;
              */ /*case 'Sleeve':
                  if(wearable.color == key2)
                    add = true;
                  else add = false;
                  break;*/ /*
              }
            }
          });
        });
        if(add && !list.contains(wearable))
          list.add(wearable);
        else if(list.contains(wearable))
          list.remove(wearable);
      });

      setState(() {
      });*/
  }
}
