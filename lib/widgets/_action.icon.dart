import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/utils/jari_icons_v1.dart';

class AppBarCustom {
  //+++++++++++++++++++++

  static Widget logoHeader() {
    return Image.asset(
      'assets/images/logo-jari-only.png',
      //fit: BoxFit.scaleDown,
      height: 58.0,
    );
  }

  //+++++++++++++++++++
  static List<Widget> actionIcon() {
    final list = Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: IconButton(
        icon: Icon(
          JariIcons.shopping_cart,
          size: 30.0,
          color: AppColors.icongray,
        ),
        onPressed: () {},

        // Icons.shopping_basket,
      ),
    );

    return [list];
  }
}
