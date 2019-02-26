import 'dart:async';

import 'package:faltu/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class AddressSelectionBloc implements BlocBase {
  var indexController = StreamController<int>();

  Observable<int> get indexStream => indexController.stream;

  void indexChanged(int index) {
    indexController.add(index);
  }

  @override
  void dispose() {
    indexController.close();
  }
}
