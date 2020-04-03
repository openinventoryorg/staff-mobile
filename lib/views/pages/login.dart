/// Login page which handles user login
library view_page_login;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_staff_app/api/flushbar/flushbar.dart';

import 'package:openinventory_staff_app/controllers/api.dart';
import 'package:openinventory_staff_app/controllers/base_url.dart';
import 'package:openinventory_staff_app/routes/router.dart';
import 'package:openinventory_staff_app/views/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const emailRegex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
  bool _hidePassword;
  bool _asyncCallOngoing;
  TextEditingController _baseUrlController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _hidePassword = true;
    _asyncCallOngoing = false;
    _baseUrlController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _baseUrlController.text = BaseUrlController.of(context).baseUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          signInLogo(context),
          form(context),
        ],
      ),
    );
  }

  /// Login Screen Icon
  Widget signInLogo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Center(
        child: Icon(
          Icons.lock_open,
          size: 154,
          color: AppColors.colorC,
        ),
      ),
    );
  }

  /// Form widget
  Widget form(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          formTextBox(
            hint: 'https://myorganization.com',
            label: 'Organization Url',
            controller: _baseUrlController,
            prefix: LineIcons.server,
            keyboard: TextInputType.emailAddress,
            helperText: 'This should be is the format http://yourwebsite.com',
          ),
          formTextBox(
            hint: '150092U@uom.lk',
            label: 'Email',
            controller: _emailController,
            prefix: LineIcons.at,
            keyboard: TextInputType.url,
          ),
          formTextBox(
            hint: 'password',
            label: 'Password',
            controller: _passwordController,
            obscureText: _hidePassword,
            keyboard: TextInputType.text,
            prefix: LineIcons.lock,
            suffix: IconButton(
              icon: _hidePassword
                  ? Icon(LineIcons.eye_slash)
                  : Icon(LineIcons.eye),
              onPressed: switchPasswordVisibility,
            ),
          ),
          RaisedButton(
            color: AppColors.colorD,
            textColor: Colors.white,
            onPressed: _asyncCallOngoing ? () {} : onSignInPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Sign-in'),
                ),
                buttonIcon(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Text box builder helper method.
  Widget formTextBox(
      {@required String hint,
      @required String label,
      @required TextEditingController controller,
      @required TextInputType keyboard,
      @required IconData prefix,
      String helperText,
      bool obscureText = false,
      Widget suffix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: suffix,
          prefixIcon: Icon(prefix),
          helperText: helperText,
        ),
      ),
    );
  }

  /// Icon of the sign in button
  Widget buttonIcon() {
    if (_asyncCallOngoing) {
      return SizedBox(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
          strokeWidth: 2,
        ),
        width: 24,
        height: 24,
      );
    } else {
      return Icon(LineIcons.arrow_right);
    }
  }

  /// Toggles the password visibility on/off
  void switchPasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  /// Log the user in using the text box values.
  /// If failed, shows a flush bar.
  void onSignInPressed() async {
    String baseUrl = _baseUrlController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    if (baseUrl.isEmpty) {
      showFlushbar('Validation Error', 'Organization Url must be provided');
    } else if (email.isEmpty) {
      showFlushbar('Validation Error', 'Email must be provided');
    } else if (!RegExp(emailRegex).hasMatch(email)) {
      showFlushbar('Validation Error', 'Email is of invalid format');
    } else if (password.isEmpty) {
      showFlushbar('Validation Error', 'Password must be provided');
    } else {
      updateAsyncCallStatus(true);
      try {
        await BaseUrlController.of(context).setBaseUrl(baseUrl);
        await ApiController.of(context).logIn(email, password);
        AppRouter.freshNavigate(context, '/home');
      } catch (err) {
        showFlushbar('Invalid Data', err.toString());
      } finally {
        updateAsyncCallStatus(false);
      }
    }
  }

  /// Updates the state of async calls.
  /// (To make sure not to send 2 async calls at once
  /// and to show an indicator)
  void updateAsyncCallStatus(bool ongoing) {
    if (mounted) {
      setState(() {
        _asyncCallOngoing = ongoing;
      });
    }
  }

  /// Shows a error message flush bar
  void showFlushbar(String title, String subtitle) {
    Flushbar(
      title: title,
      message: subtitle,
      animationDuration: Duration(milliseconds: 200),
      icon: Icon(Icons.error, color: Colors.white),
      backgroundColor: AppColors.colorC,
      duration: Duration(seconds: 1) * 2,
      leftBarIndicatorColor: AppColors.colorE,
      mainButton: FlatButton(
        child: Text('CLOSE'),
        onPressed: () => Navigator.pop(context),
        textColor: Colors.white,
      ),
    )..show(context);
  }
}
