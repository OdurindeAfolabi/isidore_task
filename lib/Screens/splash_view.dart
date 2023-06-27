import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isidore_task/Utils/color_manager.dart';
import 'package:isidore_task/Utils/font_manager.dart';
import 'package:isidore_task/Utils/styles_manager.dart';

import '../Utils/di_locator.dart';
import '../Utils/route_manager.dart';
import '../Utils/size_config.dart';
import '../navigation/navigator.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final NavigationService _navigationService = locator<NavigationService>();
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() {
    _navigationService.navigateReplacementTo(Routes.loginRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.initializeSize(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: Text("MyContactApp",style: getBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s20),),
        ),
      ),
    );
  }
}
