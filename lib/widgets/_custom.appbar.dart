import 'package:flutter/material.dart';
import 'package:jariapp/utils/_jari_icons.dart';
import 'package:jariapp/utils/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //--------
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      leading: null,
      automaticallyImplyLeading: false,
      elevation: 6,
      // toolbarHeight: 60.0,
      // title: Text(
      //   "Jari App",
      //   style: TextStyle(color: Colors.grey[800], fontSize: 20),
      // ),

      centerTitle: true,
      title: Image.asset(
        'assets/images/logo-jari-only.png',
        //fit: BoxFit.scaleDown,
        height: 58.0,
      ),

      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(
                JariIcons.shopping_cart,
                size: 32.0,
                color: AppColors.icongray,
              ),
              onPressed: () {},

              // Icons.shopping_basket,
            ))
      ],
    );
  }
}