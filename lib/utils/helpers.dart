import 'package:flutter/material.dart';
import 'package:jariapp/themes/colors.dart';

const Color colorus = const Color(0xFFFFFFFF);
const Color progColorus = const Color(0xFF0088A9);

Widget error(String error, [IconData icons]) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Center(
        child: Card(
      color: AppColors.darkgray,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          error,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    )),
  );
}

// Widget loading(Color color) {
//   return Center(
//     child: Container(
//         child: CircularProgressIndicator(
//       backgroundColor: color ?? AppColors.white,
//     )),
//   );
// }

Widget loading([Color color = colorus, Color progressColor = progColorus]) {
  return Center(
    child: Container(
        child: CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(progressColor),
      backgroundColor: color,
    )),
  );
}
