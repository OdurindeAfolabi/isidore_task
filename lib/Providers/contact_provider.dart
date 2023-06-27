import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:isidore_task/Providers/view_state.dart';
import 'package:isidore_task/Schemas/create_contact_schema.dart';
import 'package:isidore_task/Schemas/fetch_contact_schema.dart';
import 'package:isidore_task/Utils/dialog_functions.dart';
import 'package:isidore_task/Utils/helpers.dart';
import 'package:isidore_task/models/CreateContactRequest.dart';
import 'package:isidore_task/models/GetContactModel.dart';
import 'package:isidore_task/navigation/navigator.dart';
import '../Schemas/graphql_config.dart';
import '../Utils/di_locator.dart';
import '../Utils/prefs_manager.dart';

class ContactProvider extends ChangeNotifier {

  ViewState<List<Contacts>> viewState = ViewState(state: ResponseState.EMPTY);

  late BuildContext viewContext;
  final NavigationService _navigationService = locator<NavigationService>();

  List<Contacts> userContacts = [];

  setBuildContext(BuildContext context){
    viewContext = context;
  }

  void _setViewState(ViewState<List<Contacts>> viewState) {
    this.viewState = viewState;
    notifyListeners();
  }

  final EndPoint _point = EndPoint();

  ///Add task method
  void addNewContact({required CreateContactRequest createContactRequest,required BuildContext context}) async {
    showLoader(context);
    ValueNotifier<GraphQLClient> client = _point.getClient();
    if (kDebugMode) {
      print(createContactRequest.toJson());
    }
    final AppPreferences appPreferences = locator<AppPreferences>();
    if (kDebugMode) {
      print("Token: ${appPreferences.getUserToken()}");
    }
    QueryResult result = await client.value.mutate(
        MutationOptions(
            document: gql(CreateContactSchema.createContactJson),
            variables: createContactRequest.toJson()));
    if (result.hasException) {
      log(result.exception.toString());
      if (result.exception!.graphqlErrors.isEmpty) {
        _navigationService.pop();
        showErrorToast("Internet is not found");
      } else {
        _navigationService.pop();
        showErrorToast("Something went wrong");
      }
    }
    else {
      if (kDebugMode) {
        print(result.data);
      }
      _navigationService.pop();
      if(result.data?["contact"]["status"] == 200){
        showToast("Contact Added");
        getContacts();
        // _navigationService.navigateReplacementTo(Routes.homeRoute);
      }
      else{
        showErrorToast(result.data?["contact"]["errors"][0]["message"] ?? "Request failed");
      }
    }
  }

  ///update task method
  void updateContact({required CreateContactRequest createContactRequest,required BuildContext context}) async {
    showLoader(context);
    ValueNotifier<GraphQLClient> client = _point.getClient();
    if (kDebugMode) {
      print(createContactRequest.toJson());
    }
    final AppPreferences appPreferences = locator<AppPreferences>();
    if (kDebugMode) {
      print("Token: ${appPreferences.getUserToken()}");
    }
    QueryResult result = await client.value.mutate(
        MutationOptions(
            document: gql(CreateContactSchema.createContactJson),
            variables: createContactRequest.toJson()));
    if (result.hasException) {
      log(result.exception.toString());
      if (result.exception!.graphqlErrors.isEmpty) {
        _navigationService.pop();
        showErrorToast("Internet is not found");
      } else {
        _navigationService.pop();
        showErrorToast("Something went wrong");
      }
    }
    else {
      if (kDebugMode) {
        print(result.data);
      }
      _navigationService.pop();
      if(result.data?["contact"]["status"] == 200){
        showToast("Contact Updated");
        getContacts();
        // _navigationService.navigateReplacementTo(Routes.homeRoute);
      }
      else{
        showErrorToast(result.data?["contact"]["errors"][0]["message"] ?? "Request failed");
      }
    }
  }

  Future<void> getContacts() async {
    _setViewState(ViewState.loading());
    ValueNotifier<GraphQLClient> client = _point.getClient();

    QueryResult result = await client.value.query(QueryOptions(
        document: gql(FetchContactSchema.fetchContactJson),
        parserFn: GetContactModel.fromJson,
        fetchPolicy:  FetchPolicy.networkOnly));

    if (result.hasException) {
      if (kDebugMode) {
        print(result.exception);
      }
      if (result.exception!.graphqlErrors.isEmpty) {
        _setViewState(ViewState.error("Internet is not found"));
      } else {
        _setViewState(ViewState.error(result.exception!.graphqlErrors[0].message.toString()));
      }
      notifyListeners();
    } else {
      if (kDebugMode) {
        print(result.data);
      }
      var data = result.data?["contacts"];
      List<Contacts> packageList = List<Contacts>.from(
          data.map((item) => Contacts.fromJson(item)));
      if (kDebugMode) {
        print(packageList.map((e) => e.email));
      }
      _setViewState(ViewState.complete(packageList));
    }
  }
}
