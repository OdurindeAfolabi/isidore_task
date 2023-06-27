import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:isidore_task/Providers/contact_provider.dart';
import 'package:isidore_task/Providers/login_provider.dart';
import 'package:isidore_task/Providers/sign_up_provider.dart';
import 'package:provider/provider.dart';
import 'Utils/di_locator.dart';
import 'Utils/route_manager.dart';
import 'Utils/theme_manager.dart';
import 'navigation/navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  setupLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ContactProvider()),
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => SignUpProvider())
        ],
        child: MaterialApp(
          title: "Isidore Task",
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
          navigatorKey: locator<NavigationService>().navigationKey,
          theme: getApplicationTheme(),
        ));
  }
}
