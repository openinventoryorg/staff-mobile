/// Home page section in which users can search items.
library view_section_search;

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_staff_app/views/colors.dart';

class SearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          signInLogo(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Query',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () {},
                child: Text('Search'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget signInLogo() {
    return Container(
      padding: EdgeInsets.only(bottom: 24),
      child: Center(
        child: Icon(
          LineIcons.search,
          size: 100,
          color: AppColors.colorC,
        ),
      ),
    );
  }
}
