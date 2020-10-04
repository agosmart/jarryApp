import 'package:flutter/material.dart';
import 'package:jariapp/models/product..dart';
import 'package:jariapp/services/products.dart';
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

                  return ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: _productsList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_productsList[index].productName),
                      );
                    },
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
