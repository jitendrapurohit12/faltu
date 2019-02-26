import 'package:faltu/bloc/app_bloc.dart';
import 'package:faltu/bloc/bloc_provider.dart';
import 'package:faltu/shared_preferences/prefs.dart';
import 'package:faltu/ui/home/home.dart';
import 'package:faltu/ui/signin/sign_in.dart';
import 'package:flutter/material.dart';

void main() => runApp(BlocProvider(
  bloc: AppBloc(),
  child: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  AppBloc _appBloc;

  @override
  void initState() {
    super.initState();
    Prefs();
    _appBloc = BlocProvider.of<AppBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Faltu',
      home: StreamBuilder(
          stream: _appBloc.emailSnapshotStream,
          builder: (context, snapshot){
            return snapshot.hasData ? Home() : SignIn();
      }),
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
    );
  }
}
