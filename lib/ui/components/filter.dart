import 'package:faltu/listeners/confirmation_listener.dart';
import 'package:faltu/utils/method_helper.dart';
import 'package:flutter/material.dart';
import 'package:faltu/widgets/size.dart';

class Filters extends StatefulWidget {
  final type;

  Filters(this.type);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> implements ConfirmationListener {
  Map<String, Map<Object, bool>> sortMap = Map();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    sortMap = getMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: (){
            Navigator.pop(context, sortMap);
          }),
          SizedBox(width: 16.0,)],
      ),
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: sortMap.length,
                itemBuilder: (context, index) => Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => filterClicked(index),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                sortMap.keys.elementAt(index),
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          )
                        ],
                      ),
                    )),
          ),
          VerticalDivider(),
          Expanded(
            child: ListView.builder(
                itemCount: sortMap.values.elementAt(selectedIndex).length,
                itemBuilder: (context, index) => Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: getSizeWidget(index)),
                          Divider(
                            color: Colors.grey,
                          )
                        ],
                      ),
                    )),
          ),
        ],
      ),
    );
  }

  Map<String, Map<Object, bool>> getMap() => MethodHelper.getFilterMap(widget.type);

  filterClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void success(int index) {
        sortMap.values.elementAt(selectedIndex)[
            sortMap.values.elementAt(selectedIndex).keys.elementAt(index)] =
        !sortMap.values.elementAt(selectedIndex)[
            sortMap.values.elementAt(selectedIndex).keys.elementAt(index)];
  }

  Widget getSizeWidget(int index) {
    if (sortMap.values.elementAt(selectedIndex).keys.elementAt(index) is int)
      return Size(
          '         ',
          Colors.white,
          Color(sortMap.values.elementAt(selectedIndex).keys.elementAt(index)),
          sortMap.values.elementAt(selectedIndex)[
              sortMap.values.elementAt(selectedIndex).keys.elementAt(index)],
          index,
          this);
    else
      return Size(
          sortMap.values.elementAt(selectedIndex).keys.elementAt(index),
          Colors.white,
          Colors.black,
          sortMap.values.elementAt(selectedIndex)[
              sortMap.values.elementAt(selectedIndex).keys.elementAt(index)],
          index,
          this);
  }
}
