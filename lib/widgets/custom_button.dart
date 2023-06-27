import 'package:flutter/material.dart';
import 'package:isidore_task/Utils/color_manager.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final BorderRadius borderRadius;
  final Color borderColor;
  final Color? splashColor;
  final String buttonText;
  final Color buttonTextColor;

  const CustomButton({super.key,
    required this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.splashColor,
    required this.buttonText,
    this.buttonTextColor = const Color(0xffFFFFFF),
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        height: 60,
        width: deviceWidth,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: splashColor ?? ColorManager.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius,
                  side: BorderSide(color: borderColor),
                )),
            onPressed:
            onPressed == null ? null :
                () {
              onPressed!();
            },
            child: Text(
              buttonText,
              style: TextStyle(
                  color: buttonTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            )));
  }
}
