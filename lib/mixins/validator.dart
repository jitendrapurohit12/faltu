import 'dart:async';
import 'package:faltu/constants/constants.dart';

mixin Validator {
  var nameValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name == null || name.length > 0)
      sink.add(name);
    else
      sink.addError(Constants.ERROR_INVALID_NAME);
  });

  var addressValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (address, sink) {
    if (address == null || address.length > 0)
      sink.add(address);
    else
      sink.addError(Constants.ERROR_INVALID_ADDRESS);
  });

  var localityValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (locality, sink) {
    if (locality == null || locality.length > 0)
      sink.add(locality);
    else
      sink.addError(Constants.ERROR_INVALID_LOCALITY);
  });

  var cityValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (city, sink) {
    if (city == null || city.length > 0)
      sink.add(city);
    else
      sink.addError(Constants.ERROR_INVALID_CITY);
  });

  var stateValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (state, sink) {
    if (state == null || state.length > 0)
      sink.add(state);
    else
      sink.addError(Constants.ERROR_INVALID_STATE);
  });

  var mobileValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (mobile, sink) {
    if (mobile.length == 10)
      sink.add(mobile);
    else
      sink.addError(Constants.ERROR_INVALID_MOBILE);
  });

  var optionalMobileValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (mobile, sink) {
        if (mobile.length == 10 || mobile.length == 0)
          sink.add(mobile);
        else
          sink.addError(Constants.ERROR_INVALID_MOBILE);
      });

  var pinCodeValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (pin, sink) {
    if (pin.length == 6)
      sink.add(pin);
    else
      sink.addError(Constants.ERROR_INVALID_MOBILE);
  });
}
