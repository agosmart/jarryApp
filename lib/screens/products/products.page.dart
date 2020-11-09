import 'package:flutter/material.dart';
import 'package:jariapp/models/product..dart';
import 'package:jariapp/screens/products/product.details.page.dart';
import 'package:jariapp/providers/category.dart';
import 'package:jariapp/providers/products.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/utils/constantes.dart';

import 'package:jariapp/utils/helpers.dart';
import 'package:jariapp/widgets/custom.appbar.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  // //............
  // final IconData catIcon;
  // final Color catColor;
  // final String category;
  // //...........
  // const ProductsPage({Key key, this.catIcon, this.catColor, this.category})
  //     : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  //+++++
  double h, w;
  Color _catColor;
  IconData _catIcon;
  String _catName;
  String _categoryId;

  //------
  Future<List<Product>> _futureFetching;
  ProductsProvider _productsProvider;
  CategoryProvider _categoryProvider;
  List<Product> _productsList;
  //+++++
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _productsList = [];
    //.......... INIT Products / category Provider ...............
    _categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    _categoryId = _categoryProvider.currentCategoryID;

    _productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    //.......... INIT FutureBuilder ...............
    // _futureFetching = _productsProvider.fetchProductsByCategoryLocal();
    _futureFetching =
        _productsProvider.fetchProductsByCategoryAPI(categoryId: _categoryId);
    //-------------
  }

  //+++++
  @override
  Widget build(BuildContext context) {
    //++++
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    _catColor = _categoryProvider.currentCatColor;
    _catIcon = _categoryProvider.currentCatIcon;
    _catName = _categoryProvider.currentCategoryName;

    print('_catName ${_catName.toString()}');

    //+++++
    return Scaffold(
      // backgroundColor: Colors.grey[100],

      backgroundColor: AppColors.canvaColor,

      //+++++

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
        actions: <Widget>[CustomAppBar.builsActionIcons()],
        // toolbarHeight: 80.0,
      ),

      //-----------------
      body: SafeArea(
        //======
        child: FutureBuilder(
          future: _futureFetching,
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapShot) {
            //++++++
            switch (snapShot.connectionState) {
              case ConnectionState.none:
                // return Text('nothing happend !!!');
                return error('No connexion made!');
                break;
              case ConnectionState.waiting:
              case ConnectionState.active:
                //  return Center();
                return loading(AppColors.akablueLight);
                break;
              case ConnectionState.done:
                if (snapShot.hasError) {
                  return error(snapShot.error.toString());
                } else {
                  if (!snapShot.hasData) {
                    return error('Data messing!');
                  }

                  //return Text('${snapShot.data}');
                  _productsList = [...snapShot.data];
                  print('_productsList ::: $_productsList');

                  return Column(
                    children: [
                      //++++
                      Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 20, right: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              // Color(0xFF0090DF),
                              // Color(0xFF0090DF).withOpacity(0.4),
                              //...........................
                              _catColor,
                              _catColor.withOpacity(0.4),
                              //...........................
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //...... icon ........
                            Icon(
                              //...........................
                              _catIcon,
                              //JariIcons.danone_ferme,
                              //...........................
                              color: AppColors.white,
                              size: 42.0,
                            ),
                            SizedBox(width: 16.0),
                            //.... Title .....
                            Flexible(
                              flex: 4,
                              child: Text(
                                //...........................
                                '$_catName',
                                //'YAOURT DANONE FERME',
                                //...........................
                                //softWrap: true,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Spacer(flex: 1),
                            //....... Product RESULT  .......
                            Expanded(
                              flex: 2,
                              //child: Text('10 produits'),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: AppColors.darkblue.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                //=======
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: '${_productsList.length}',
                                        style: TextStyle(
                                          // color: AppColors.darkblue,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    TextSpan(
                                        text: _productsList.length <= 1
                                            ? ' produit'
                                            : ' produits',
                                        style: TextStyle(
                                          //  color: AppColors.darkblue,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ]),
                                ),
                                //=======
                              ),
                            ),
                            //.....
                          ],
                        ),
                      ),
                      //++++
                      SizedBox(height: 16),
                      //++++
                      Expanded(
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.0),
                                  Colors.white.withOpacity(0.95),
                                  Colors.white,
                                  Colors.white.withOpacity(0.9),
                                  Colors.white.withOpacity(0.0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [
                                  0,
                                  0.03,
                                  0.8,
                                  0.9,
                                  0.95,
                                ]).createShader(bounds);
                          },
                          //+++++ END VIEW BUILDER +++++++
                          child: Column(
                            children: [
                              Flexible(
                                // flex: 12,
                                child: ListView.builder(
                                  // padding: const EdgeInsets.only(
                                  //     top: 20, bottom: 20, left: 20, right: 20),

                                  itemCount: _productsList.length,
                                  itemBuilder: (context, index) {
                                    //....... SEt CURRENt PRODUCT.......................

                                    Product _currentProd = _productsList[index];

                                    //.................................................
                                    return ListTile(
                                      //++++++++++++++++++++++++++++
                                      onTap: () {
                                        //+.+.+.+.+.+ SET CURRENT PRODUCT .+.+.+.+.+.+.+
                                        _productsProvider
                                            .setCurrentProduct(_currentProd);
                                        //+.+.+.+.+.+.+.+.+.+.++.+.+.+.+.+.+.+.+.+.+.+.+

                                          Navigator.pushNamed(context, '/productDetailsPage');

                                      /*  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            //-------------------------------------------------
                                            builder: (BuildContext context) {
                                              return ProductDetailsPage();
                                            },
                                            fullscreenDialog: true,

                                            //--------------------------------------------------
                                          ),
                                        );*/
                                      },
                                      //++++++++++++++++++++++++++++
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18.0,
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 16.0,
                                          right: 16.0,
                                          top: 8.0,
                                          bottom: 8.0),
                                      //..............................
                                      title: Text(
                                        '${_productsList[index].productName}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      //++++++++++
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, bottom: 4.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          //-------------
                                          children: [
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: 'Prix Unitaire : ',
                                                    style: TextStyle(
                                                      color: AppColors.darkgray,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                                TextSpan(
                                                    text:
                                                        '${_productsList[index].unitPrice}',
                                                    style: TextStyle(
                                                      color: AppColors.darkgray,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                                TextSpan(
                                                    text: ' DA',
                                                    style: TextStyle(
                                                      color: AppColors.darkblue,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    )),
                                              ]),
                                            ),
                                            //-------

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0, bottom: 4.0),
                                              child: Text(
                                                  'Quantité  Min : ${_productsList[index].minimumOrder}',
                                                  style: TextStyle(
                                                    color: AppColors.darkgray,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //+++++++++++
                                      isThreeLine: true,

                                      //+++++++++++
                                      leading: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 8,
                                                  spreadRadius: 5,
                                                  color: AppColors.black
                                                      .withOpacity(0.2))
                                            ]),

                                        //=================
                                        child: CircleAvatar(
                                            backgroundColor: AppColors.white,

                                            //backgroundImage:
                                            child: Image.network(
                                              '${IMAGEURL + _productsList[index].image}',
                                              //'http://danone.cooffa.shop/data_app/storage/app/public/products/images/placehoder.png',

                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace stackTrace) {
                                                // Appropriate logging or analytics, e.g.
                                                // myAnalytics.recordError(
                                                //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                                                //   exception,
                                                //   stackTrace,
                                                // );
                                                return Text(
                                                  '😢',
                                                  style:
                                                      TextStyle(fontSize: 24),
                                                );
                                              },
                                            )

                                            /*asset(
                                                  'assets/images/products/${_productsList[index].image}')
                                              : Image.asset(
                                                  'assets/images/products/3.png'),
                                            */
                                            // backgroundImage: AssetImage(
                                            //   'assets/images/products/${_productsList[index].image}',
                                            // ),
                                            ),
                                        //=================
                                      ),
                                    );
                                  },
                                ),
                              ),

                              //.+.+.+.+.+.+.+.+
                              SizedBox(
                                height: 24.0,
                              )
                              //.+.+.+.+.+.+.+.+
                            ],
                          ),
                          //+++++ END VIEW BUILDER +++++++
                        ),
                      ),
                    ],
                  );
                }
            }
            return Container(
              child: Center(child: Text('ERROR FETCHING PRODUCTS!')),
            );

            //++++++
          },
        ),
        //======
      ),
    );
  }
}
