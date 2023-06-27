import 'package:flutter/material.dart';

class ColorManager {
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color primary = HexColor.fromHex("#FFFFFF");
  static Color secondary = HexColor.fromHex("#21244a");
  static Color secondaryLight = HexColor.fromHex("#e7e7ff");
  static Color isidoreGrey = HexColor.fromHex("#a3a3a3");
  static Color grey = HexColor.fromHex("#b5b5b1");
  static Color lightGrey = HexColor.fromHex("#ebebeb");
  static Color orangeDeep = HexColor.fromHex("#ffe7eb");
  static Color orangeLight = HexColor.fromHex("#fff4f4");
  static Color contactCardTextColor = HexColor.fromHex("#4f5060");


  static Color neutralColor =  HexColor.fromHex("#8EA3BF");
  static Color borderColor = HexColor.fromHex("#4D4362");
  static Color circleAvatarGrey = HexColor.fromHex("#D9D9D9");


// new colors
  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color errorColor = const Color(0xFFF61515);
  static Color grey1 = HexColor.fromHex("#E5E5E5");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color grey3 = HexColor.fromHex("#2E4B72");
  static Color grey4 = HexColor.fromHex("#8E8E93");
  static Color black= HexColor.fromHex("#000000"); // black color
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
