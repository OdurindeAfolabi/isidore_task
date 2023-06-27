import 'package:flutter/material.dart';
import 'package:isidore_task/Utils/color_manager.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;
  const ErrorScreen({Key? key, required this.errorMessage, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber,
              color: ColorManager.errorColor,
              size: 50,
            ),
            const SizedBox(height: 8,),
            Text(errorMessage),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(2.0),
                backgroundColor: MaterialStateProperty.all<Color>(
                  ColorManager.white,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                      color: ColorManager.secondary,
                    ),
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                child: Text(
                  "Retry",
                  style: TextStyle(
                    color: ColorManager.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}