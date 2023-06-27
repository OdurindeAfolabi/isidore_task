import 'package:flutter/material.dart';
import 'package:isidore_task/Utils/assets_manager.dart';
import 'package:isidore_task/Utils/color_manager.dart';
import 'package:isidore_task/Utils/font_manager.dart';
import 'package:isidore_task/Utils/route_manager.dart';
import 'package:isidore_task/Utils/styles_manager.dart';
import 'package:isidore_task/Utils/values_manager.dart';
import 'package:isidore_task/widgets/custom_button.dart';

import '../Utils/di_locator.dart';
import '../navigation/navigator.dart';
class SignUpSuccessView extends StatelessWidget {
  const SignUpSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = locator<NavigationService>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(ImageAssets.successImage,height: AppSize.s200,width: AppSize.s200,)
              ),
              const SizedBox(height: AppSize.s24,),
              Text("Verification email sent!",style: getBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s20),),
              const SizedBox(height: AppSize.s12,),
              Text("Please check your email to verify your mycontactapp account",
                textAlign: TextAlign.center,
                style: getSemiBoldStyle(color: ColorManager.isidoreGrey,fontSize: FontSize.s16),),
              const SizedBox(height: AppSize.s45,),
              SizedBox(
                width: AppSize.s200,
                child: CustomButton(
                    onPressed: (){
                      ///sign up does not return valid token..so we can't route to home screen
                      navigationService.pushAndRemoveUntil(Routes.loginRoute);
                    },
                    buttonText: "Done"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
