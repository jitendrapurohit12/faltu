import 'dart:async';

import 'package:faltu/bloc/bloc_provider.dart';
import 'package:faltu/shared_preferences/get_preferences.dart';

class AppBloc implements BlocBase {

  StreamController<String> emailController = StreamController<String>();
  StreamController<String> imageController = StreamController<String>();
  StreamController<String> nameController = StreamController<String>();
  StreamController<String> phoneController = StreamController<String>();
  StreamController<String> genderController = StreamController<String>();
  StreamController<String> idController = StreamController<String>();

  StreamSink<String> get emailSnapshot => emailController.sink;

  Stream<String> get emailSnapshotStream => emailController.stream;

  StreamSink<String> get imageSnapshot => imageController.sink;

  Stream<String> get imageSnapshotStream => imageController.stream;

  StreamSink<String> get nameSnapshot => nameController.sink;

  Stream<String> get nameSnapshotStream => nameController.stream;

  StreamSink<String> get phoneSnapshot => phoneController.sink;

  Stream<String> get phoneSnapshotStream => phoneController.stream;

  StreamSink<String> get genderSnapshot => genderController.sink;

  Stream<String> get genderSnapshotStream => genderController.stream;

  StreamSink<String> get idSnapshot => idController.sink;

  Stream<String> get idSnapshotStream => idController.stream;

  AppBloc() {
    GetPreferences.getName().then((userName) {
      nameSnapshot.add(userName);
    });

    GetPreferences.getEmail().then((email) {
      emailSnapshot.add(email);
    });

    GetPreferences.getURL().then((url) {
      imageSnapshot.add(url);
    });

    GetPreferences.getPhone().then((phone) {
      phoneSnapshot.add(phone);
    });

    GetPreferences.getGender().then((gender) {
      genderSnapshot.add(gender);
    });

    GetPreferences.getId().then((id) {
      idSnapshot.add(id);
    });
  }

  @override
  void dispose() {
    emailController.close();
    imageController.close();
    nameController.close();
    phoneController.close();
    genderController.close();
    idController.close();
  }
}
