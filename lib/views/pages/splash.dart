/// Splash screen which redirects users to home or login
/// depending on their logged in status
library view_page_splash;

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:openinventory_staff_app/controllers/token.dart';
import 'package:openinventory_staff_app/routes/router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _userEmail;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SpinKitDualRing(
            color: Theme.of(context).accentColor,
            size: MediaQuery.of(context).size.height * 0.1,
          ),
          if (_userEmail != null)
            Positioned(
              child: Text(
                _userEmail,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              bottom: 16,
            ),
        ],
      ),
    );
  }

  /// Authenticates the user.
  ///
  /// Gets the user email and if the user is logged in redirects to home.
  /// Otherwise redirects to login page
  void _authenticate() async {
    String currentUserEmail = await _getCurrentEmail();
    setState(() {
      _userEmail = currentUserEmail;
    });

    // Wait a second to aviod flikrs
    await Future.delayed(Duration(seconds: 1));

    String targetRoute;
    if (currentUserEmail == null) {
      targetRoute = "/login";
    } else {
      targetRoute = "/home";
    }

    if (mounted) {
      AppRouter.freshNavigate(context, targetRoute);
    }
  }

  /// Gets current email from Controller.
  Future<String> _getCurrentEmail() {
    return TokenController.of(context).tokenLoadedCompleter.future;
  }
}
