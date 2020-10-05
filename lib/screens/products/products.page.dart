import 'package:flutter/material.dart';
import 'package:jariapp/models/product..dart';
import 'package:jariapp/services/products.dart';
import 'package:jariapp/utils/_jari_icons.dart';
import 'package:jariapp/utils/colors.dart';

import 'package:jariapp/utils/helpers.dart';

import 'package:jariapp/widgets/animations/action.icon.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  //const ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  //+++++
  double h, w;
  Future<List<Product>> _futureFetching;
  ProductsProvider _productsProvider;
  List<Product> _productsList;
  //+++++
  @override
  void initState() {
    super.initState();
    _productsList = [];
    //.......... INIT Products Provider ...............
    _productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    //.......... INIT FutureBuilder ...............
    _futureFetching = _productsProvider.fetchProductsByCategoryLocal();
    //-------------
  }

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
                            gradient: LinearGradient(colors: [
                          Color(0xFF0090DF),
                          Color(0xFF0090DF).withOpacity(0.4),
                        ])),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //...... icon ........
                            Icon(
                              JariIcons.danone_ferme,
                              color: AppColors.white,
                              size: 42.0,
                            ),
                            SizedBox(width: 16.0),
                            //.... Title .....
                            Flexible(
                              flex: 4,
                              child: Text(
                                'YAOURT DANONE FERME',
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
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: '10',
                                      style: TextStyle(
                                        color: AppColors.darkblue,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  TextSpan(
                                      text: ' produit(s)',
                                      style: TextStyle(
                                        color: AppColors.darkblue,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ]),
                              ),
                            ),
                            //.....
                          ],
                        ),
                      ),
                      //++++
                      Expanded(
                        child: ListView.builder(
                          // padding: const EdgeInsets.only(
                          //     top: 20, bottom: 20, left: 20, right: 20),
                          itemCount: _productsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: const EdgeInsets.all(8.0),
                              title: Text(_productsList[index].productName),
                              leading: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: AppColors.white,
                                  //backgroundImage:
                                  child: _productsList[index].image != '1.png'
                                      ? Image.asset(
                                          'assets/images/products/${_productsList[index].image}')
                                      : Image.asset(
                                          'assets/images/products/3.png'),
                                  // backgroundImage: AssetImage(
                                  //   'assets/images/products/${_productsList[index].image}',
                                  // ),
                                ),
                              ),
                            );
                          },
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
