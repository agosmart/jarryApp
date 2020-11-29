import 'dart:ui';

import 'package:jarryApp/themes/colors.dart';

abstract class TextStyles {
  //+++++
  static get text18Dark {
    //-----
    return TextStyle(
      fontFamily: 'Bariol',
      color: AppColors.white,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    );
  }

  //+++++

  static get text20Dark {
    return TextStyle(
      fontFamily: 'Bariol',
      color: AppColors.darkgray,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
  }
}
