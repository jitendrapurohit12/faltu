import 'package:faltu/bloc/product_block.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/listeners/filter_and_sort_listener.dart';
import 'package:faltu/models/moke/wearable_unit.dart';
import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/ui/components/filter.dart';
import 'package:faltu/ui/components/wearable_list_ui.dart';
import 'package:faltu/utils/ly_appbar.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class MenProducts extends StatefulWidget {
  final String type, category;

  const MenProducts({Key key, this.type, this.category}) : super(key: key);

  @override
  MenProductsState createState() {
    return new MenProductsState();
  }
}

class MenProductsState extends State<MenProducts> implements FAndSListener {
  Map<String, Map<Object, bool>> sortMap;
  ProductBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ProductBloc(widget.type, widget.category, Constants.MALE);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.appbar(context, widget.type ?? widget.category, true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: UIHelper.filterAndSort(this),
            ),
            StreamBuilder(
                stream: _bloc.productStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return WearableListUI(snapshot.data, sortMap);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  @override
  void filter() async {
    final result = await Navigation.filters(context, Constants.TSHIRT);

    setState(() {
      sortMap = result;
    });
  }

  @override
  void sort() {}
}
