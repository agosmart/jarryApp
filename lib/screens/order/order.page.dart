import 'package:flutter/material.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/widgets/custom.appbar.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,

          // leading: null,
          iconTheme: IconThemeData(color: AppColors.icongray),
          backgroundColor: CustomAppBar.backgroundColor,
          automaticallyImplyLeading: true,
          centerTitle: CustomAppBar.centerTitle,

          elevation: CustomAppBar.elevation,
          toolbarHeight: CustomAppBar.toolbarHeight,
          title: CustomAppBar.logoHeader(),
          // actions: <Widget>[CustomAppBar.builsActionIcons()],
          //  actions: <Widget>[CustomAppBar.builsActionIconsClear()],
          // toolbarHeight: 80.0,
        ),

        //--------------------------
        body: Center(
          child: Text('TRANSACTION'),
        ),
      ),
    );
  }
}
