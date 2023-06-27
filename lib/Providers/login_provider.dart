import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:isidore_task/Schemas/login_schema.dart';
import 'package:isidore_task/Utils/dialog_functions.dart';
import 'package:isidore_task/Utils/helpers.dart';
import 'package:isidore_task/Utils/route_manager.dart';
import 'package:isidore_task/models/LoginRequest.dart';
import 'package:isidore_task/navigation/navigator.dart';

import '../Schemas/graphql_config.dart';
import '../Utils/di_locator.dart';
import '../Utils/prefs_manager.dart';

class LoginProvider extends ChangeNotifier {

  final NavigationService _navigationService = locator<NavigationService>();
  final AppPreferences _appPreferences = locator<AppPreferences>();

  final EndPoint _point = EndPoint();

  ///Add task method
  void loginUser({required LoginRequest loginRequest,required BuildContext context}) async {
    showLoader(context);
    ValueNotifier<GraphQLClient> client = _point.getClient();

    QueryResult result = await client.value.mutate(
        MutationOptions(
            document: gql(LoginSchema.loginJson),
            variables: loginRequest.toJson()));
    if (result.hasException) {
      log(result.exception.toString());
      if (result.exception!.graphqlErrors.isEmpty) {
        _navigationService.pop();
        showErrorToast("Internet is not found");
      } else {
        _navigationService.pop();
        showErrorToast("Something went wrong");
      }
    } else {
      if (kDebugMode) {
        print(result.data);
      }
      _navigationService.pop();
      // SignUpModel response = SignUpModel.fromJson(result.data);
      if(result.data?["login"]["status"] == 200){
        if (kDebugMode) {
          print("token ${result.data?["login"]["user"]["tokens"] ?? ""}");
        }
        await _appPreferences.setUserToken(result.data?["login"]["user"]["tokens"] ?? "");
        _navigationService.navigateReplacementTo(Routes.homeRoute);
        showToast("Authenticated");
      }
      else{
        showErrorToast(result.data?["login"]["errors"][0]["message"] ??"Invalid Username or password");
      }
    }
  }
}
