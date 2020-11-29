import 'package:flutter/material.dart';
import 'package:jarryApp/themes/colors.dart';

const Color colorus = const Color(0xFFFFFFFF);
const Color progColorus = const Color(0xFF0088A9);

Widget error(String error, [IconData icons]) {
  print('error::: $error');
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Center(
        child: Container(
      decoration: BoxDecoration(
          color: AppColors.darkblue4,
          borderRadius: BorderRadiusDirectional.circular(16.0)),
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

Widget error2(String error, Function func) {
  print('error::: $error');
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: Center(
        child: Container(
      decoration: BoxDecoration(
          color: AppColors.darkblue4,
          borderRadius: BorderRadiusDirectional.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.refresh_rounded,
                  color: AppColors.white,
                  size: 32,
                ),
                onPressed: func)
          ],
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
