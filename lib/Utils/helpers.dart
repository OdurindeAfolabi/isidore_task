import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

customYMargin(double value) {
  return SizedBox(height: value);
}

customXMargin(double value) {
  return SizedBox(width: value);
}


String capitalize(val) {
  return "${val[0].toUpperCase()}${val.substring(1)}";
}


class Validators {
  static String? isLength(String? value, int length,
      {String fieldName = "Field"}) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    } else if (value.length != length) {
      return "Must be of length $length";
    } else {
      return null;
    }
  }

  static bool isBase64(String str) {
    try {
      base64.decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  String? isEmpty(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else {
      return null;
    }
  }
  String? isPhone(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (value.length == 11) {
      return null;
    } else {
      return 'Invalid Phone number';
    }
  }
  String? isPin(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (value.length == 4) {
      return null;
    } else {
      return 'Invalid PIN';
    }
  }

  String? isPassword(value) {
    if (value.isEmpty) {
      return 'Field Required';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must have at least one uppercase letter.';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must have at least one lowercase letter.';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must have at least one number.';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must have at least one special character.';
    } else if (value.length < 8) {
      return 'Password must be a minimum of 8 characters.';
    } else if (validateStructure(value)) {
      return null;
    } else {
      return null;
      // return "Passwords must:\nBe a minimum of 8 characters\nInclude at least one number(0-9) \nInclude one special character \nInclude at least one uppercase letter(A-Z)\nInclude at least one lowercase letter(a-z)";
    }
  }

  String? isEmail(value) {
    if (value.isEmpty) {
      return 'Email Required';
    } else if (validateEmail(value)) {
      return null;
    } else {
      return 'Invalid email';
    }
  }
  String? isEmail2(value) {
    if (value.isEmpty) {
      return null;
    } else if (validateEmail(value)) {
      return null;
    } else {
      return 'Invalid email';
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}

widthSizer(double value, BuildContext context, {figmaWidth = 412}) {
  // 412 is the default design screen width on figma
  return MediaQuery.of(context).size.width *
      (value / figmaWidth); // width size on figma
}

heightSizer(double value, BuildContext context, {figmaHeight = 870}) {
  // 870 is the default design screen height on figma
  return MediaQuery.of(context).size.height *
      (value / figmaHeight); // height size on figma
}

showToast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

showErrorToast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
