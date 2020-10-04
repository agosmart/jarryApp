import 'package:flutter/material.dart';
import 'package:jariapp/utils/_jari_icons.dart';
import 'package:jariapp/utils/colors.dart';
import 'package:jariapp/widgets/_custom.appbar.dart';
import 'package:jariapp/widgets/animations/action.icon.dart';

class ProductsPage extends StatelessWidget {
  //const ProductsPage({Key key}) : super(key: key);

  double h, w;

  @override
  Widget build(BuildContext context) {
    //++++
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    //+++++
    return Scaffold(
      // backgroundColor: Colors.grey[100],

      backgroundColor: AppColors.canvaColor1,

      //+++++

      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        // leading: null,
        automaticallyImplyLeading: true,
        elevation: 6,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.icongray),
        title: AppBarCustom.logoHeader(),
        actions: AppBarCustom.actionIcon(),
      ),

      //-----------------
      body: SafeArea(
        child: Center(),
      ),
    );
  }
}
