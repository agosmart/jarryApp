import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/category.dart';
import 'package:jariapp/screens/products/products.page.dart';
import 'package:jariapp/services/category.dart';
import 'package:jariapp/services/exeptions/exeptions.dart';
import 'package:jariapp/utils/colors.dart';
import 'package:jariapp/utils/helpers.dart';
import 'package:jariapp/utils/jari_icons.dart';
import 'package:jariapp/widgets/_custom.appbar.dart';
import 'package:jariapp/widgets/animations/action.icon.dart';
// import 'package:jariapp/utils/_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //++++++
  double w;
  double h;

  static const List<IconData> iconsMenuList = [
    JariIcons.danone_ferme,
    JariIcons.danone_fromage,
    JariIcons.danone_jus,
    JariIcons.danone_yaourt,
    JariIcons.danone_brasse,
    JariIcons.danone_dessert,
    JariIcons.danone_any,
  ];

  static const List<Color> menuColorsList = [
    Color(0xFF0090DF),
    Color(0xFFE04F00),
    Color(0xFFE93E49),
    Color(0xFF2158C7),
    Color(0xFFFB9600),
    Color(0xFF39AE7C),
    Color(0xFF7A71F0),
    Color(0xFF737FA6),
    Color(0xFFD153A7),
    Color(0xFF8DB243),
    Color(0xFFCC9544),
    Color(0xFF39A2AE),
  ];

  Future<List<Category>> _futureFetchingCat;

  List<Category> categoryList;

  CategoryProvider categoryProvider;

  //+++++categoryProvider
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryList = [];
    categoryProvider = CategoryProvider();

    //============================================
    _futureFetchingCat = categoryProvider.fetchCategoriesLocal();
    //  _futureFetchingCat = categoryProvider.fetchCategoriesLocal(); //_getFutureCategories();
    //============================================
  }

  // Future<List<Category>> _getFutureCategories() async {
  //   // return await _orderProvider.fetchNotTraitedOrdersLocal(idUser: 1);
  //   return await categoryProvider.fetchCategoriesLocal();
  // }

  //+++++

  @override
  Widget build(BuildContext context) {
    //++++
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    //+++++
    return Scaffold(
      // backgroundColor: Colors.grey[100],

      backgroundColor: AppColors.canvaColor1,

      //appBar: CustomAppBar() as AppBar,

      //+++++

      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: null,
        automaticallyImplyLeading: false,
        elevation: 6,
        centerTitle: true,

        title: AppBarCustom.logoHeader(),
        actions: AppBarCustom.actionIcon(),
        // title: Image.asset(
        //   'assets/images/logo-jari-only.png',
        //   //fit: BoxFit.scaleDown,
        //   height: 58.0,
        // ),
        // actions: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: IconButton(
        //       icon: Icon(
        //         JariIcons.shopping_cart,
        //         size: 32.0,
        //         color: AppColors.icongray,
        //       ),
        //       onPressed: () {},

        //       // Icons.shopping_basket,
        //     ),
        //   )
        // ],
      ),

      //-----------------
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          //fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            //+++++ Boc Background Image +++++++++
            Positioned(
              top: -22,
              child: Container(
                width: w,
                height: h / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/pattern3.jpg',
                    ),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            //+++++ Bloc header+++++++++

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              //-----
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    //-----
                    // color: Colors.red.withOpacity(0.2),
                    //-----
                    // padding: const EdgeInsets.only(top: 24.0),
                    height: h / 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Bienvenue',
                                  style: TextStyle(
                                    // fontFamily: 'Bariol',
                                    color: AppColors.darkblue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 36,
                                  ),
                                ),
                                Text(
                                  'sur jari!',
                                  style: TextStyle(
                                    // fontFamily: 'Bariol',
                                    color: AppColors.lightblue3,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 48,
                                  ),
                                ),
                                //
                              ],
                            ),
                          ),
                          //-----
                          SizedBox(
                            width: 10.0,
                          ),

                          //++++++
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Image.asset('assets/images/logo-jari1.png'),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),

                //+++++++++++++++++++++++++++++++++++

                //+++++ Future  List ategory +++++++++

                //+++++++++++++++++++++++++++++++++++

                Flexible(
                  flex: 5,
                  child: FutureBuilder(
                    //----------------------------------
                    future: _futureFetchingCat,
                    //----------------------------------
                    //_orderProvider.fetchtNotTraitedOrders(idUser: 1),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Category>> snapShot) {
                      switch (snapShot.connectionState) {
                        case ConnectionState.none:
                          // return Text('nothing happend !!!');
                          return error('No connexion made!');
                          break;
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          return Center();
                          //   return loading(AppColors.akablueLight);
                          break;
                        case ConnectionState.done:
                          if (snapShot.hasError) {
                            return error(snapShot.error.toString());
                          } else {
                            if (!snapShot.hasData) {
                              // return error('Acune catégorie n\'est disponible !');
                              return buildError();
                            }

                            //------------------
                            // print(snapShot.data);

                            categoryList = [...snapShot.data];

                            return ClipRect(
                              child: ShaderMask(
                                //blendMode: BlendMode.dstATop,
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.0),
                                        Colors.white.withOpacity(0.9),
                                        Colors.white,
                                        Colors.white,
                                        Colors.white.withOpacity(0.9),
                                        Colors.white.withOpacity(0.0),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [
                                        0.05,
                                        0.14,
                                        0.20,
                                        0.87,
                                        0.9,
                                        0.95
                                      ]).createShader(bounds);
                                },
                                child: Container(
                                  // color: Colors.red.withOpacity(0.5),
                                  height: (h * 3 / 4) - 40,
                                  padding: const EdgeInsets.only(
                                      top: 0,
                                      left: 20.0,
                                      right: 20.0,
                                      bottom: 0.0),
                                  //+++++++
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(child: buildGrideCategories()),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      }
                      return error('Data messing! 22222');
                    },
                  ),
                ),

                //+++++++++++++
              ],
              //-----

              //-----
            ),

            //+++++
          ],
        ),
      ),
    );
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Widget buildError() {
    return Container(
      height: (h * 3 / 4) - 60.0,
      padding: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 80.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
              child: Text(
            'Acune catégorie n\'est disponible !',
            style: TextStyle(
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }

  // Widget buildLoading() {
  //   return Container(
  //     height: (h * 3 / 4) - 60.0,
  //     padding: const EdgeInsets.only(
  //         top: 10.0, left: 20.0, right: 20.0, bottom: 80.0),
  //     child: Card(
  //       elevation: 5.0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(16.0),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(30.0),
  //         child: Center(
  //           child: CircularProgressIndicator(),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildGrideCategories() {
    //++++

    return GridView.builder(
      //shrinkWrap: true,
      itemCount: categoryList.length,
      padding: const EdgeInsets.all(10.0),
      scrollDirection: Axis.vertical,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        //----------
        final category = categoryList[index];
        final categoryName = category.familleName.toUpperCase();
        // final iconId = ((category.familleId) - 1).toInt();
        return _buildCategoryItem(categoryName, index);
        //----------
      },
    );
  }

//----------------------
  //++++

  Widget _buildCategoryItem(categoryName, index) {
    //+++++++
    index = index > 6 ? 7 : index;
    //+++++++

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Card(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //  color: Colors.red.withOpacity(0.3),
                    child: Flexible(
                      flex: 1,
                      child: Icon(
                        iconsMenuList[index],
                        color: menuColorsList[index],
                        size: 60.0,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        '$categoryName',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 0.6,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightblue3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            //-------------------------------------------------
            builder: (BuildContext context) => ProductsPage(),
            //--------------------------------------------------
          ),
        );
      },
      /* onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          child: CupertinoAlertDialog(
            title: Column(
              children: <Widget>[
                Text("GridView"),
                Icon(
                  Icons.favorite,
                  color: Colors.green,
                ),
              ],
            ),
            content: Text("Selected Item $index"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          ),
        );
      },*/
    );
  }

//-------------------

}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
class DemoShader extends StatefulWidget {
  const DemoShader({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  _DemoShaderState createState() => _DemoShaderState();
}

class _DemoShaderState extends State<DemoShader> {
  double _closeToTheEdge = 0.0;

  bool _handleScrollNotification(ScrollNotification notification) {
    final ScrollMetrics metrics = notification.metrics;
    final double t =
        (((metrics.extentInside - metrics.extentAfter) / metrics.extentInside)
            .clamp(0.0, 1.0));
    // if (t != _closeToTheEdge) {
    //   setState(() {
    //     _closeToTheEdge = t;
    //   });
    // }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: widget.child,
      ),
      shaderCallback: (Rect bounds) {
        return LinearGradient.lerp(
          const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFFFFFFF), Color(0x00FFFFFF)],
            stops: <double>[0.6, 0.9],
          ),
          const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
          ),
          _closeToTheEdge,
        ).createShader(bounds);
      },
    );
  }
}
*/
