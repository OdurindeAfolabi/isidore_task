

import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:isidore_task/Utils/di_locator.dart';

import '../Utils/constants.dart';
import '../Utils/prefs_manager.dart';

class EndPoint {
  final AppPreferences _appPreferences = locator<AppPreferences>();
  ValueNotifier<GraphQLClient> getClient(){
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: HttpLink(
            endpointUrl,
            defaultHeaders: <String,String>{
              "Authorization" : "Bearer ${_appPreferences.getUserToken()}"
            }
        ),
        cache: GraphQLCache(store: HiveStore()),
      )
    );

    return client;
  }
}