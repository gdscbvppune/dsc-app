import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:after_layout/after_layout.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import '../services/authService.dart';
import '../services/buttonBuilder.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AfterLayoutMixin<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isProgressVisible = false;
  bool _isButtonDisabled = false;
  bool _isBackgroundVisible = false;
  bool _isTitleVisible = false;

  void _toggleProgressVisibility() {
    setState(() => _isProgressVisible = !_isProgressVisible);
  }

  void _toggleButtonVisibility() {
    setState(() => _isButtonDisabled = !_isButtonDisabled);
  }

  Widget _showSnackBar(text) {
    return SnackBar(
      content: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  Widget _loginButton() {
    return GoogleSignInButton(
      progressVisible: _isProgressVisible,
      borderRadius: 20.0,
      onPressed: _isButtonDisabled
          ? null
          : () async {
              _toggleButtonVisibility();
              _toggleProgressVisibility();
              if (!await AuthProvider().signInWithGoogle()) {
                _toggleButtonVisibility();
                _toggleProgressVisibility();
                print("Error logging in with google !");
                _scaffoldKey.currentState.showSnackBar(_showSnackBar("An error occured !"));
              }
            },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() => _isBackgroundVisible = !_isBackgroundVisible);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: DoubleBackToCloseApp(
        snackBar: _showSnackBar("Tap back again to exit"),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                "assets/images/dsc_login_background.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.65),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: 35.0),
                    AnimatedOpacity(
                      opacity: _isBackgroundVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.fastOutSlowIn,
                      child: SvgPicture.asset(
                        "assets/svg/gdglogo.svg",
                        height: 400.0,
                      ),
                      onEnd: () => setState(() => _isTitleVisible = !_isTitleVisible),
                    ),
                    AnimatedContainer(
                      height: _isTitleVisible ? 120.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: Text(
                        "Developer\nStudent\nClubs",
                        style: GoogleFonts.lato(
                          letterSpacing: 1.5,
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _isTitleVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.fastOutSlowIn,
                      child: AnimatedPadding(
                        padding: _isTitleVisible ? EdgeInsets.symmetric(vertical: 50.0) : EdgeInsets.zero,
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.fastOutSlowIn,
                        child: _loginButton(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final String text;
  final double borderRadius;
  final VoidCallback onPressed;
  final bool progressVisible;

  GoogleSignInButton({
    this.onPressed,
    this.text = 'Sign in with',
    this.borderRadius = 3.0,
    this.progressVisible = false,
  });

  Widget _progressImage() {
    return progressVisible
        ? Padding(
            padding: EdgeInsets.all(6.5),
            child: CircularProgressIndicator(),
          )
        : Image(
            image: AssetImage("assets/logos/google_logo.png"),
            height: 21.0,
            width: 21.0,
          );
  }

  @override
  Widget build(BuildContext context) {
    return StretchableButton(
      buttonColor: Color(0xFF4285F4),
      borderRadius: borderRadius,
      onPressed: onPressed,
      buttonPadding: 0.0,
      children: <Widget>[
        SizedBox(width: 14.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
          child: Text(
            text,
            style: GoogleFonts.lato(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 38.0,
            width: 38.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(this.borderRadius),
            ),
            child: Center(
              child: _progressImage(),
            ),
          ),
        ),
      ],
    );
  }
}
