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
  const wellness({super.key});

  @override
  Widget build(BuildContext context) {
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
