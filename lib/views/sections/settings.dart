/// Home page section in which users can change settings and view profile.
library view_section_settings;

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:openinventory_staff_app/controllers/api.dart';
import 'package:openinventory_staff_app/routes/router.dart';

class SettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = ApiController.of(context).user;

    if (user == null) {
      // Fallback to logout instead of showing an error
      logout(context);
    }

    return Column(
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
              listTile(LineIcons.user, user.name, "Name", context),
              listTile(LineIcons.list, user.role, "Account Type", context),
              listTile(LineIcons.at, user.email, "Email", context),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlineButton.icon(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.exit_to_app),
            label: Text('Logout'),
          ),
        ),
      ],
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

  /// Logs the user out
  Future<void> logout(BuildContext context) async {
    await ApiController.of(context).logOut();
    AppRouter.freshNavigate(context, '/');
  }
}
