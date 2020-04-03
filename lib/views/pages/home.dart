library view_page_home;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:openinventory_staff_app/helpers.dart';
import 'package:openinventory_staff_app/routes/router.dart';
import 'package:openinventory_staff_app/views/colors.dart';
import 'package:openinventory_staff_app/controllers/socket.dart';
import 'package:openinventory_staff_app/views/common/connection_ball.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool connected = SocketController.of(context, true).isConnected;

    return Scaffold(
      appBar: AppBar(
        title: Text('Open Inventory'),
        actions: <Widget>[ConnectionBall()],
      ),
      body: (!connected)
          ? disconnectedWidget()
          : Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: GridView.count(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      children: <Widget>[
                        HomePageButton(
                          text: 'Scan Barcodes',
                          icon: AntDesign.scan1,
                          onPressed: () => sendBarcodeToWebApp(context),
                        ),
                        HomePageButton(
                          text: 'Lend Item',
                          icon: AntDesign.save,
                          onPressed: () {},
                        ),
                        HomePageButton(
                          text: 'Receieve Item',
                          icon: AntDesign.find,
                          onPressed: () {},
                        ),
                        HomePageButton(
                          text: 'Temporary Handover',
                          icon: AntDesign.clockcircleo,
                          onPressed: () {},
                        ),
                        HomePageButton(
                          text: 'Profile',
                          icon: AntDesign.user,
                          onPressed: () =>
                              AppRouter.navigate(context, '/profile'),
                        ),
                        HomePageButton(
                          text: 'Logout',
                          icon: AntDesign.logout,
                          onPressed: () => Helpers.logout(context),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget disconnectedWidget() {
    return Column(
      children: <Widget>[
        Card(
          color: AppColors.colorC,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                'You are not connected to the web app. ',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Recheck your internet connection. If the problem persists try restarting app.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }

  void sendBarcodeToWebApp(BuildContext context) async {
    String code = await Helpers.scanQR();
    if (code == null) return;

    SocketController.of(context).sendMessage({'barcode': code});
  }
}

class HomePageButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const HomePageButton(
      {Key key, @required this.text, @required this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: onPressed,
        child: GridTile(
          child: Container(
            color: AppColors.colorB,
            child: Icon(
              icon,
              size: 56,
            ),
          ),
          footer: Container(
            padding: EdgeInsets.all(8),
            color: Theme.of(context).accentColor.withOpacity(0.8),
            child: AutoSizeText(
              text,
              style: _LabCardStyles.title,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}

abstract class _LabCardStyles {
  static TextStyle get title => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get subtitle => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
      );
}
