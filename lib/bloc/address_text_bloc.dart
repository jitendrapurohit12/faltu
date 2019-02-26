import 'package:faltu/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:faltu/mixins/validator.dart';

class AddressTextBloc extends Object with Validator implements BlocBase {
  var nameController = BehaviorSubject<String>();
  var primaryMobileController = BehaviorSubject<String>();
  var alternateMobileController = BehaviorSubject<String>();
  var pincodeController = BehaviorSubject<String>();
  var addressController = BehaviorSubject<String>();
  var localityController = BehaviorSubject<String>();
  var cityController = BehaviorSubject<String>();
  var stateController = BehaviorSubject<String>();

  //-----------------------------------------------------------------------------

  Observable<String> get name => nameController.stream.transform(nameValidator);

  Observable<String> get primaryMobile =>
      primaryMobileController.stream.transform(mobileValidator);

  Observable<String> get alternateMobile =>
      alternateMobileController.stream.transform(optionalMobileValidator);

  Observable<String> get pincode =>
      pincodeController.stream.transform(pinCodeValidator);

  Observable<String> get address =>
      addressController.stream.transform(addressValidator);

  Observable<String> get locality =>
      localityController.stream.transform(localityValidator);

  Observable<String> get city => cityController.stream.transform(cityValidator);

  Observable<String> get state =>
      stateController.stream.transform(stateValidator);

  //-----------------------------------------------------------------------------

  Function(String) get nameChanged => nameController.sink.add;

  Function(String) get primaryMobileChanged => primaryMobileController.sink.add;

  Function(String) get alternateMobileChanged =>
      alternateMobileController.sink.add;

  Function(String) get pincodeChanged => pincodeController.sink.add;

  Function(String) get addressChanged => addressController.sink.add;

  Function(String) get localityChanged => localityController.sink.add;

  Function(String) get cityChanged => cityController.sink.add;

  Function(String) get stateChanged => stateController.sink.add;

  //-----------------------------------------------------------------------------

  Observable<bool> get profileCheck => Observable.combineLatest8(
      name,
      primaryMobile,
      alternateMobile,
      pincode,
      address,
      locality,
      city,
      state,
      (name, primary, alternate, pincode, address, locality, city, state) =>
          true);

  @override
  void dispose() {
    nameController.close();
    primaryMobileController.close();
    addressController.close();
    alternateMobileController.close();
    pincodeController.close();
    localityController.close();
    cityController.close();
    stateController.close();
  }
}
