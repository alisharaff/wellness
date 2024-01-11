import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wellness/config/route.dart';

import 'package:wellness/theme/theme.dart';

import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const wellness());
}

class wellness extends StatelessWidget {
  const wellness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      
      title: 'Wellness Track App',
      theme: AppTheme.lightTheme,
      routes: Routes.getRoute(),
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      debugShowCheckedModeBanner: false,
      initialRoute: "SplashPage",
    );
  }
}
