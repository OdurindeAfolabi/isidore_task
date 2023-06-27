import 'package:get_it/get_it.dart';
import 'package:isidore_task/Utils/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation/navigator.dart';
GetIt locator = GetIt.instance;

Future<void> setupLocator() async {

  locator.registerLazySingleton(() => NavigationService());

  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  locator.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  // app prefs instance
  locator.registerLazySingleton<AppPreferences>(() => AppPreferences(locator()));
}