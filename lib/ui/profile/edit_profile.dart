import 'package:faltu/bloc/app_bloc.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/firebase_services/firebase_services.dart';
import 'package:faltu/listeners/bool_listener.dart';
import 'package:faltu/models/individual/profile.dart';
import 'package:faltu/shared_preferences/set_preferences.dart';
import 'package:faltu/utils/ly_appbar.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:faltu/bloc/profile_text_block.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> implements BoolListener {
  String _gender = Constants.MALE;
  TextEditingController _nameController, _phoneController;
  AppBloc _appBloc;
  TextBloc _textBloc;

  TextInputType numberType =
      TextInputType.numberWithOptions(decimal: false, signed: false);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _textBloc = TextBloc();
    _appBloc = AppBloc();
    getPreferences();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _textBloc.dispose();
    _appBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.appbar(context, Constants.EDIT_PROFILE, false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 40.0),
            Center(
              child: StreamBuilder<String>(
                stream: _appBloc.imageSnapshotStream,
                builder: (context, snapshot) => CircleAvatar(
                      radius: 56.0,
                      backgroundImage:
                          NetworkImage(snapshot != null ? snapshot.data : ''),
                    ),
              ),
            ),
            SizedBox(height: 36.0),
            UIHelper.getStringStreamBuilderWithBorder(
                context,
                _textBloc.name,
                _textBloc.nameChanged,
                Constants.HINT_NAME,
                _nameController,
                null,
                40),
            SizedBox(height: 16.0),
            UIHelper.getStringStreamBuilderWithBorder(
                context,
                _textBloc.primary,
                _textBloc.primaryChanged,
                Constants.HINT_PHONE,
                _phoneController,
                numberType,
                10),
            SizedBox(height: 24.0),
            genderSelector(),
            SizedBox(height: 56.0),
            StreamBuilder<bool>(
              stream: _textBloc.profileCheck,
              builder: (context, snapshot) => RaisedButton(
                    onPressed: snapshot.hasData ? () => save() : null,
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    color: Colors.black,
                    splashColor: Colors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }

  void getPreferences() {
    _appBloc.nameSnapshotStream.listen((data) {
      _nameController.value =
          _nameController.value.copyWith(text: data == null ? '' : data);
    });
    _appBloc.phoneSnapshotStream.listen((data) {
      _phoneController.value =
          _phoneController.value.copyWith(text: data == null ? '' : data);
    });

    _appBloc.genderSnapshotStream.listen((data) {
      setState(() {
        _gender = data ?? Constants.MALE;
      });
    });
  }

  Widget genderSelector() {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => setGender(Constants.MALE),
            child: Container(
              height: 45.0,
              decoration: UIHelper.customContainerDecoration(
                  Colors.white, getBorderColor(Constants.MALE), 1.0, 8.0),
              child: Center(
                child: Text(Constants.MALE),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setGender(Constants.FEMALE),
            child: Container(
              height: 45.0,
              decoration: UIHelper.customContainerDecoration(
                  Colors.white, getBorderColor(Constants.FEMALE), 1.0, 8.0),
              child: Center(
                child: Text(Constants.FEMALE),
              ),
            ),
          ),
        )
      ],
    );
  }

  Color getBorderColor(String gender) {
    Color color = gender == _gender ? Colors.black : Colors.white;
    return color;
  }

  setGender(String gender) {
    setState(() {
      _gender = gender;
    });
  }

  void save() {
    UIHelper.showProgressDialog(context: context, message: 'Updating Profile');
    FirebaseService firebaseService = FirebaseService();
    Profile profile = Profile(
        name: _nameController.text,
        gender: _gender,
        image: null,
        phone: _phoneController.text);
    firebaseService.updateProfile(profile, this);
  }

  @override
  void success(bool result) {
    if (result) {
      Navigator.pop(context);
      SetPreferences.saveName(_nameController.text);
      SetPreferences.savePhone(_phoneController.text);
      SetPreferences.saveGender(_gender);
      Navigator.pop(context);
    } else
      UIHelper.showErrorDialog(context, Constants.ERROR_UPDATE_PROFILE);
  }
}
