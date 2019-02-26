import 'package:faltu/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:faltu/mixins/validator.dart';

class TextBloc extends Object with Validator implements BlocBase {
  var nameController = BehaviorSubject<String>();
  var primaryController = BehaviorSubject<String>();

  Observable<String> get name =>
      nameController.stream.transform(nameValidator);

  Observable<String> get primary =>
      primaryController.stream.transform(mobileValidator);

  Observable<bool> get profileCheck =>
      Observable.combineLatest2(name, primary, (name, primary) => true);

  Function(String) get nameChanged => nameController.sink.add;

  Function(String) get primaryChanged => primaryController.sink.add;

  @override
  void dispose() {
    nameController?.close();
    primaryController?.close();
  }
}
