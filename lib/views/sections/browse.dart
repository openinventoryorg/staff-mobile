/// Home page section in which users can browse labs.
library view_section_browse;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openinventory_staff_app/routes/router.dart';
import 'package:openinventory_staff_app/views/colors.dart';

class BrowseSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 2,
      children: <Widget>[
        LabCard(),
        LabCard(),
        LabCard(),
        LabCard(),
        LabCard(),
      ],
    );
  }
}

class LabCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: () => onLabCardPress(context),
        child: GridTile(
          child: Container(
            color: AppColors.colorB,
            child: Icon(
              LineIcons.laptop,
              size: 56,
            ),
          ),
          footer: Container(
            padding: EdgeInsets.all(8),
            color: Theme.of(context).accentColor.withOpacity(0.8),
            child: Column(
              children: <Widget>[
                AutoSizeText(
                  'Embedded Systems Laboratory',
                  style: _LabCardStyles.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                AutoSizeText(
                  'Lab on floor 13',
                  style: _LabCardStyles.subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLabCardPress(BuildContext context) {
    AppRouter.navigate(context, '/home/lab/1');
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
