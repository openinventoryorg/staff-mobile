/// Home page section in which users can change settings and view profile.
library view_page_profile;

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:openinventory_staff_app/controllers/api.dart';
import 'package:openinventory_staff_app/helpers.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = ApiController.of(context).user;

    if (user == null) {
      // Fallback to logout instead of showing an error
      Helpers.logout(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  color: Theme.of(context).accentColor,
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 120,
                  ),
                ),
                listTile(AntDesign.user, user.name, "Name", context),
                listTile(AntDesign.tago, user.role, "Account Type", context),
                listTile(AntDesign.mail, user.email, "Email", context),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlineButton.icon(
              onPressed: () {
                Helpers.logout(context);
              },
              icon: Icon(Icons.exit_to_app),
              label: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  Widget listTile(
    IconData icon,
    String title,
    String subtitle,
    BuildContext context,
  ) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).accentColor),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}
