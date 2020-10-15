import 'package:flutter/material.dart';

abstract class AppColors {
  //  static MaterialColor get primary => const MaterialColor(0xFF0088A9, null);

  // static MaterialColor myGreen = const MaterialColor(0xFFAAD400, {});

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

//--------------------------------------------------------

  static const Color titleTextColor = const Color(0xff1d2635);
  static const Color subTitleTextColor = const Color(0xff797878);
  static const Color icongray_1 = const Color(0xFF9299A5);

  static const Color orange = Color(0xffE65829);

  static Color get transparent => Colors.transparent;
  // static Color get black => const Color(0xFF222222);
  static Color get black => const Color(0xff20262C);
  static Color get lightblack => const Color(0xff5F5F60);
  static Color get white => const Color(0xFFFFFFFF);

  static Color get lightGrey => const Color(0xffE1E2E4);
  static Color get grey => const Color(0xffA1A3A6);
  static Color get darkgrey => const Color(0xff747F8F);

  static Color get canvaColor => const Color(0xFFF3F3F3);
//++++ ICONS COLOR +++++
  static Color get icongray => const Color(0xFF9299A5);
  static Color get darkgray => const Color(0xFF4e5b60);
  static Color get darkblue => const Color(0xFF002775);
  static Color get lightblue => const Color(0xFF008FD7);

  static Color get darkblue2 => const Color(0xFF263a44);
  static Color get darkblue4 => const Color(0xFF164179);
  static Color get darkblue3 => const Color(0xFF072449);

  static Color get lightblue2 => const Color(0xFF48a1af);
  static Color get lightblue3 => const Color(0xFF006B8B);
  static Color get lightblue4 => const Color(0xFF4695FF);
  static Color get akablueLight => const Color(0xFF1DDDEB);
  static Color get greenLight => const Color(0xFF8DB243);
  static Color get gold => const Color(0xFFFFBE27);

  static Color get pinck => const Color(0xFFee5253);
  static Color get red => const Color(0xFFee5253);

  //++++++

  // static Color get canvaColor => const Color(0xFFF8F9FB);

  // static Color get canvaColor2 => const Color(0xFFFCF9F4);
  // static Color get white => const Color(0xFFFFFFFF);

  // static Color get darkgray_2 => const Color(0xFFACAEB5);
  // static Color get lightgray => const Color(0xFFc8d6ef);
  // static Color get lightgray_2 => const Color(0xFFBEBEBE);

  // static Color get neonBlue => const Color(0xFF263a44);

  //

  // static Color get orange => const Color(0xFFFF7F5D);

  // static Color get gold => const Color(0xFFFFBE27);
  // static Color get lightgold => const Color(0xFFFFEFAC);
  // static Color get straw => const Color(0xFFe2a84b);

  // static Color get pinck => const Color(0xFFee5253);
  // static Color get red => const Color(0xFFee5253);

  // static Color get green => const Color(0xFF3b7d02);
  // static Color get lightGreen => const Color(0xFF5DBF8E);
  // static Color get lightGreen_2 => const Color(0xFF4DD937);
  // static Color get teal => const Color(0xFF00C7AE);

  // static Color get facebook => const Color(0xFF3b5998);

  // static Color get google => const Color(0xFF4285f4);
  // static Color get searchBarColor => const Color(0XFF21243C);

  ///-----------------------

//   Non traitée -->initial
// Refusée -->rejected
// Acceptée non assignée --> accepted
// Assignée non achetée -->affectedNot
// Achetée non contrôlée
// Contrôlé non livré
// Livré
/*
Not_treated
Refused
Accepted not assigned
Assignee not purchased
Purchased uncontrolled
Checked not delivered
Delivered
*/

  // static Color get notTreated => const Color(0xFFACAEB5);
  // static Color get refused => const Color(0xFFFF7F5D);
  // static Color get acceptedNotAssigned => const Color(0xFF8985F3);
  // static Color get assignedNotAccepted => const Color(0xFFACAEB5); // shopper
  // static Color get assignedNotPurchased => const Color(0xFFFFAD08);
  // // static Color get purchasedUnchecked => const Color(0xFF39D6F9);
  // static Color get purchasedUnchecked => const Color(0xFF11C98C);
  // static Color get checkedNotDelivered => const Color(0xFF7FD628);
  // static Color get delivered => const Color(0xFF4695FF);
}
