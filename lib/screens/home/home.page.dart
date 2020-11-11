import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jariapp/models/category.dart';
import 'package:jariapp/screens/products/products.page.dart';
import 'package:jariapp/providers/category.dart';
import 'package:jariapp/themes/colors.dart';

import 'package:jariapp/utils/helpers.dart';
import 'package:jariapp/utils/jari_icons_v2.dart';

import 'package:jariapp/widgets/custom.appbar.dart';
import 'package:provider/provider.dart';
import 'package:jariapp/root/routes.dart';
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
    JariIcons.danone_brasse,
    JariIcons.danone_yaourt,
    JariIcons.danone_jus,
    JariIcons.danone_fromage,
    JariIcons.danone_dessert,
    JariIcons.danone_any,
  ];

  Future<List<Category>> _futureFetchingCat;

  List<Category> categoryList;

  CategoryProvider _categoryProvider;

  //+++++categoryProvider
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryList = [];
    //_categoryProvider = CategoryProvider();

    _categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    //============================================
    // _futureFetchingCat = _categoryProvider.fetchCategoriesLocal();
    _futureFetchingCat =
        _categoryProvider.fetchCategoriesAPI(); //_getFutureCategories();
    //============================================
  }

  // Future<List<Category>> _getFutureCategories() async {
  //   // return await _orderProvider.fetchNotTraitedOrdersLocal(idUser: 1);
  //   return await categoryProvider.fetchCategoriesLocal();
  // }

  //+++++

  Function refreshData() {
    //_futureFetchingCat = _categoryProvider.fetchCategoriesAPI();

    Navigator.popAndPushNamed(context, '/homePage');
  }

  @override
  Widget build(BuildContext context) {
    //++++++++++++++++++++++++++++++++++++++++
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    //+++++++++++++++++++++++++++++++++++++++++
    return WillPopScope(
      onWillPop: () async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Êtes-vous sûr de vouloir quitter ?'),
          actions: <Widget>[
            RaisedButton(
                child: Text('Quitter'),
                onPressed: () => {Navigator.of(context).pop(true)}),
            RaisedButton(
                child: Text('Annuler'),
                onPressed: () => Navigator.of(context).pop(false)),
          ],
        ),
      ),
      child: Scaffold(
        // backgroundColor: Colors.grey[100],

        backgroundColor: AppColors.canvaColor,

        //appBar: CustomAppBar() as AppBar,

        //+++++

        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
          brightness: Brightness.light,

          centerTitle: CustomAppBar.centerTitle,
          backgroundColor: CustomAppBar.backgroundColor,
          elevation: CustomAppBar.elevation,
          toolbarHeight: CustomAppBar.toolbarHeight,
          title: CustomAppBar.logoHeader(),
          actions: <Widget>[CustomAppBar.builsActionIcons()],
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
                  height: (h / 2) - h / 10,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/pattern3.webp',
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
                      height: (h / 4),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    'Bienvenue',
                                    style: TextStyle(
                                      color: AppColors.white.withOpacity(0.75),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 36,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'sur ',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 36,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Jarry!',
                                        style: TextStyle(
                                          // fontFamily: 'Bariol',
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 36,
                                        ),
                                      ),
                                    ]),
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
                              child:
                                  Image.asset('assets/images/logo-jari1.webp'),
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
                            // return Center();
                            return loading(AppColors.akablueLight);
                            break;
                          case ConnectionState.done:
                            if (snapShot.hasError) {
                              return error2(
                                  snapShot.error.toString(), refreshData);
                            } else {
                              if (!snapShot.hasData) {
                                // return error('Acune catégorie n\'est disponible !');
                                return buildError();
                              }
                              //------------------
                              // print(snapShot.data);

                              categoryList = [...snapShot.data];

                              return ShaderMask(
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
                                      SizedBox(height: 10.0),
                                      Expanded(child: buildGrideCategories()),
                                      SizedBox(height: 24.0),
                                    ],
                                  ),
                                ),
                              );
                            }
                        }
                        return error('Data messing!');
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
      padding: const EdgeInsets.only(top: 30),
      scrollDirection: Axis.vertical,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (BuildContext context, int index) {
        //----------
        final category = categoryList[index];

        final categoryId = category.categoryId.toString();
        final categoryName = category.categoryName.toUpperCase();
        // final iconId = ((category.familleId) - 1).toInt();
        return _buildCategoryItem(categoryName, categoryId, index);
        //----------
      },
    );
  }

//----------------------
  //++++

  Widget _buildCategoryItem(categoryName, categoryId, index) {
    //+++++++
    final _index = index > 6 ? 7 : index;
    //+++++++

    final _color = AppColors.menuColorsList[_index];
    final _icon = iconsMenuList[_index];
    final _categoryName = categoryName;
    final _categoryID = categoryId;

    //++++++

    return Container(
      // padding: const EdgeInsets.only(top: 20.0),
      child: GestureDetector(
        onTap: () {
          //-------------------------------

          _categoryProvider.setCurrentCategoryName(_categoryName);
          _categoryProvider.setCurrentCategoryID(_categoryID);

          _categoryProvider.setCurrentCatColor(_color);
          _categoryProvider.setCurrentCatIcon(_icon);

          //-------------------------------
          Navigator.pushNamed(context, '/productsPage');
          /*
          Navigator.push(
            context,
            MaterialPageRoute(
              //-------------------------------------------------
              builder: (BuildContext context) => ProductsPage(),
              //--------------------------------------------------
            ),
          );
          */
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          // child: Material(
          //   borderRadius: BorderRadius.circular(16),
          elevation: 6.0,
          shadowColor: AppColors.darkblue.withOpacity(0.3),
          child: Container(
            //color: Colors.amber.withOpacity(0.5),

            // padding:
            //     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              //mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Icon(
                    // iconsMenuList[_index],
                    // color: AppColors.menuColorsList[_index],
                    _icon,
                    color: _color,
                    size: 48.0,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      '$categoryName',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.0,
                          letterSpacing: 0.4,
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
    );
  }

//-------------------

}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++
