import 'package:flutter/material.dart';
import 'package:isidore_task/Providers/login_provider.dart';
import 'package:isidore_task/Utils/color_manager.dart';
import 'package:isidore_task/Utils/font_manager.dart';
import 'package:isidore_task/Utils/helpers.dart';
import 'package:isidore_task/Utils/route_manager.dart';
import 'package:isidore_task/Utils/size_config.dart';
import 'package:isidore_task/Utils/styles_manager.dart';
import 'package:isidore_task/Utils/values_manager.dart';
import 'package:isidore_task/models/LoginRequest.dart';
import 'package:isidore_task/widgets/custom_button.dart';
import 'package:isidore_task/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';

import '../Utils/di_locator.dart';
import '../navigation/navigator.dart';
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig.initializeSize(context);
    return ViewModelBuilder<LoginProvider>.reactive(
        viewModelBuilder: () => LoginProvider(),
        onViewModelReady: (v) async {
        },
        builder: (BuildContext context, LoginProvider viewModel, Widget? child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:AppPadding.p24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text("MyContactsApp",
                        textAlign: TextAlign.center,
                        style: getBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s24),),
                    ),
                    SizedBox(height: getProportionateScreenHeight(AppSize.s50),),
                    Text("Sign In",
                      style: getBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s20),),
                    const SizedBox(height: AppSize.s5,),
                    Text("Log into your mycontactapp account",
                      style: getBoldStyle(color: ColorManager.isidoreGrey,fontSize: FontSize.s12),),
                    const SizedBox(height: AppSize.s24,),
                    TxtForm(
                      textHeader: Text("Email",style: getSemiBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s16),),
                      editingController: emailController,
                      textFieldHint: "example@gmail.com",
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators().isEmail,),
                    const SizedBox(height: AppSize.s24,),
                    TxtForm(
                      textHeader: Text("Password",style: getSemiBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s16),),
                      editingController: passwordController,
                      textFieldHint: '*******',
                      inputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      obscure: passwordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on password Visible state choose the icon
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: ColorManager.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      validator: Validators().isEmpty,),
                    const SizedBox(height: AppSize.s24,),
                    CustomButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            viewModel.loginUser(loginRequest: LoginRequest(
                              email: emailController.text,
                              password: passwordController.text
                            ), context: context);
                            // Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
                          }
                        }, buttonText: "Login"),
                    SizedBox(height: getProportionateScreenHeight(AppSize.s36),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                          style: getBoldStyle(color: ColorManager.isidoreGrey,fontSize: FontSize.s16),),
                        TextButton(
                          onPressed: (){
                            _navigationService.navigateTo(Routes.signupRoute);
                          },
                          child: Text("Sign up",
                            style: getBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s16),),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
  }
}
