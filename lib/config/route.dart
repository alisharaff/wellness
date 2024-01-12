import 'package:flutter/material.dart';
import 'package:wellness/Screens/LogIn/logIn.dart';
import 'package:wellness/Screens/home/patient/widgets/detail_page.dart';
import 'package:wellness/navPages/CreatNewDatePage.dart';
import 'package:wellness/Screens/home/patient/HomePage.dart';
import 'package:wellness/Screens/signUp_pages/Pharmacy_SignUp.dart';
import 'package:wellness/Screens/signUp_pages/doctor_Signup.dart';
import 'package:wellness/splash_page.dart';
import 'package:wellness/widgets/coustom_route.dart';

import '../Screens/signUp_pages/patient_ signUp.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (context) => const SplashPage("SplashPage"),
      '/HomePage': (_) => HomePage(),
      'LoginPage': (_) => const LoginPage(
            role: 1,
          ),
      'SignupPage': (_) => const SignupPage('SignupPage'),
      'doctor_Signup': (_) => const DoctorSignup('doctor_Signup'),
      'Pharmacy_SignUp': (_) => const Pharmacy_SignUp('Pharmacy_SignUp'),
     // 'CreatNewDatePage': (_) => const CreatNewDatePage('CreatNewDatePage'),
    };
  }

  static onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name!.split('/');
    if (pathElements[0] != '' || pathElements.length == 1) {
      return null;
    }
    switch (pathElements[1]) {
      case "DetailPage":
        return CustomRoute<bool>(
            builder: (BuildContext context) => DetailPage(
                  model: settings.arguments,
                ));
    }
  }
}
