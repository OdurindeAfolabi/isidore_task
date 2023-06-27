import 'package:flutter/material.dart';
import 'package:isidore_task/Providers/sign_up_provider.dart';
import 'package:isidore_task/Utils/color_manager.dart';
import 'package:isidore_task/Utils/font_manager.dart';
import 'package:isidore_task/Utils/helpers.dart';
import 'package:isidore_task/Utils/size_config.dart';
import 'package:isidore_task/Utils/styles_manager.dart';
import 'package:isidore_task/Utils/values_manager.dart';
import 'package:isidore_task/models/SignUpRequest.dart';
import 'package:isidore_task/widgets/custom_button.dart';
import 'package:isidore_task/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';

import '../Utils/di_locator.dart';
import '../navigation/navigator.dart';
class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = locator<NavigationService>();
    SizeConfig.initializeSize(context);
    return ViewModelBuilder<SignUpProvider>.reactive(
        viewModelBuilder: () => SignUpProvider(),
        onViewModelReady: (v) async {
          v.setBuildContext(context);
        },
        builder: (BuildContext context, SignUpProvider viewModel, Widget? child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:AppPadding.p24,vertical: AppPadding.p16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: heightSizer(AppSize.s70, context),),
                    Center(
                      child: Text("MyContactsApp",
                        textAlign: TextAlign.center,
                        style: getBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s24),),
                    ),
                    SizedBox(height: getProportionateScreenHeight(AppSize.s50),),
                    Text("Sign Up",
                      style: getBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s20),),
                    const SizedBox(height: AppSize.s5,),
                    Text("Create your mycontactapp account",
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
                      validator: Validators().isPassword,),
                    const SizedBox(height: AppSize.s24,),
                    TxtForm(
                      textHeader: Text("Confirm password",style: getSemiBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s16),),
                      editingController: confirmPasswordController,
                      textFieldHint: '*******',
                      inputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      obscure: confirmPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on password Visible state choose the icon
                          confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: ColorManager.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          });
                        },
                      ),
                      validator: (value) => (value ?? "").isEmpty ? "Field required" :
                      value != passwordController.text ?
                      "Passwords do not match" : null,
                    ),
                    const SizedBox(height: AppSize.s24,),
                    CustomButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            viewModel.signUpUser(signUpRequest: SignUpRequest(
                                userInput: UserInput(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    passwordConfirmation: confirmPasswordController.text
                                )));
                            // Navigator.of(context).pushReplacementNamed(Routes.signupSuccessRoute);
                          }
                        },
                        buttonText: "Create Account"),
                    SizedBox(height: getProportionateScreenHeight(AppSize.s36),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                          style: getBoldStyle(color: ColorManager.isidoreGrey,fontSize: FontSize.s16),),
                        TextButton(
                          onPressed: (){
                            navigationService.pop();
                          },
                          child: Text("Sign in",
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
