import 'package:faltu/animations/bouncy_button.dart';
import 'package:faltu/navigatior/navigation.dart';
import 'package:faltu/shared_preferences/set_preferences.dart';
import 'package:faltu/utils/ui_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() {
    return new SignInState();
  }
}

class SignInState extends State<SignIn> with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  Animation<double> _buttonAnimation;

  var _buttonText = 'Sign In with Google';

  Widget get getButtonNestedWidget => _buttonText == null
      ? UIHelper.circularProgress()
      : WidthAnimationBuilder(
          _buttonAnimation,
          UIHelper.logInButton(
              UIHelper.buttonText(_buttonText, Colors.black), Colors.white));

  @override
  void initState() {
    super.initState();

    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    final CurvedAnimation buttonCurve =
        CurvedAnimation(parent: _loginButtonController, curve: Curves.ease);
    _buttonAnimation = Tween(begin: 250.0, end: 50.0).animate(buttonCurve);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    Future<FirebaseUser> _signInWithGoogle() async {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user = await _auth.signInWithCredential(credential);
      if (user != null) {
        SetPreferences.saveEmail(user.email);
        SetPreferences.saveName(user.displayName);
        SetPreferences.saveURL(user.photoUrl);
        SetPreferences.savePhone(user.phoneNumber);
        SetPreferences.saveId(user.uid);
      }
      return user;
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            UIHelper.extendedCircle(height: MediaQuery.of(context).size.height),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 1.5),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      await _runAnimation();
                      _signInWithGoogle()
                          .then((user) => Navigation.home(context))
                          .catchError((error) {
                        _loginFailed(error, context);
                        UIHelper.showErrorDialog(context, error);
                      });
                    },
                    child: getButtonNestedWidget,
                  ),
                )),
          ],
        ));
  }

  Future<void> _runAnimation() async {
    setState(() {
      _buttonText = '';
    });
    await _loginButtonController.forward();

    if (_loginButtonController.status == AnimationStatus.completed) {
      setState(() {
        _buttonText = null;
      });
    }
  }

  _loginFailed(String error, BuildContext context) async {
    setState(() {
      _buttonText = '';
    });
    await _loginButtonController.reverse();
    setState(() {
      _buttonText = 'Sign In with Google';
    });
  }
}
