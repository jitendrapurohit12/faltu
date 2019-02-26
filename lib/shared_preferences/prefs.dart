import 'package:faltu/bloc/app_bloc.dart';

class Prefs {
  AppBloc _appBloc = AppBloc();
  static String fid;

  Prefs(){
    _appBloc.idSnapshotStream.listen((id){
      fid = id;
      _appBloc.dispose();
    });
  }
}