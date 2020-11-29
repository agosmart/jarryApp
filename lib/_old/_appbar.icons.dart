import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jarryApp/providers/products.dart';

import 'package:jarryApp/themes/colors.dart';
import 'package:jarryApp/utils/jari_icons_v2.dart';

import 'package:provider/provider.dart';

// class CustomAppBarIcons {

// }

class CustomAppBarIcons extends StatelessWidget {
  const CustomAppBarIcons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final _productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    return _buildActionIcon();
  }

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

  //+++++++++++++++++++
  Widget _buildActionIcon() {
    return Row(
      children: [
        //+++++++++++++++++++

        Selector<ProductsProvider, int>(
            selector: (context, _productsProvider) =>
                _productsProvider.getItemCount,
            builder: (_, getItemCount, child) {
              print('TOTAL PRICE ::::$getItemCount');
              return Center(
                child: Text(
                  '$getItemCount',
                  style: TextStyle(
                    color: AppColors.black,
                  ),
                ),
              );
            }),

        //+++++++++++++++++++++
        Padding(
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
        ),
      ],
    );
  }
}
