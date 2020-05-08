import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pageHandler.dart';
import '../pages/splashPage.dart';
import '../pages/loginPage.dart';

class AuthHandler extends StatelessWidget {
  Widget _pageSwitcher(page) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 750),
      switchInCurve: Curves.fastOutSlowIn,
      transitionBuilder: (child, animation) => SizeTransition(sizeFactor: animation, child: child),
      child: page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return SplashPage();
        else if (snapshot.hasData && snapshot.data != null) {
          return _pageSwitcher(PageHandler(
            snapshot.data.displayName,
            snapshot.data.email,
            snapshot.data.photoUrl,
          ));
        } else
          return _pageSwitcher(LoginPage());
      },
    );
  }
}
