import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:isidore_task/Schemas/sign_up_schema.dart';
import 'package:isidore_task/Utils/helpers.dart';
import 'package:isidore_task/models/SignUpRequest.dart';

import '../Schemas/graphql_config.dart';
import '../Utils/di_locator.dart';
import '../Utils/dialog_functions.dart';
import '../Utils/route_manager.dart';
import '../navigation/navigator.dart';

class SignUpProvider extends ChangeNotifier {

  final NavigationService _navigationService = locator<NavigationService>();
  late BuildContext viewContext;

  setBuildContext(BuildContext context){
    viewContext = context;
  }


  final EndPoint _point = EndPoint();

  ///Add task method
  void signUpUser({required SignUpRequest signUpRequest}) async {
    showLoader(viewContext);
    ValueNotifier<GraphQLClient> client = _point.getClient();

    QueryResult result = await client.value.mutate(
        MutationOptions(
            document: gql(SignUpSchema.signUpJson),
            variables: signUpRequest.toJson()));

    if (result.hasException) {
      log(result.exception.toString());
      if (result.exception!.graphqlErrors.isEmpty) {
        _navigationService.pop();
        showErrorToast("Internet is not found");
      } else {
        _navigationService.pop();
        showErrorToast(result.exception!.graphqlErrors[0].message.toString());
      }
    } else {
      if (kDebugMode) {
        print(result.data?["signup"]);
      }
      if(result.data?["signup"]["status"] == 200){
        _navigationService.navigateReplacementTo(Routes.signupSuccessRoute);
        showToast("Registration completed");
      }
      else{
        _navigationService.pop();
        showErrorToast(result.data?["signup"]["errors"][0]["fullMessage"] ?? "Sign up failed");
      }
    }
  }
}
