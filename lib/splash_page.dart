import 'package:flutter/material.dart';
import 'package:wellness/theme/light_color.dart';
import 'package:wellness/theme/text_styles.dart';
import 'package:wellness/theme/extention.dart';

import 'Screens/home/patient/HomePage.dart';
import 'Screens/role/role_ui.dart';

class SplashPage extends StatefulWidget {
  // ignore: use_super_parameters
  const SplashPage(String s, {key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChooseRoleScreen() //HomePage(),
            ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage("lib/assets/doctor_face.jpg"),
                //   fit: BoxFit.fill,
                // ),
                ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: .6,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [LightColor.purpleExtraLight, LightColor.purple],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.mirror,
                      stops: [.5, 6]),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Image.asset(
                "lib/assets/logo.png",
                color: Colors.white,
                height: 100,
              ),
              Text(
                "Wellness Track App",
                style: TextStyles.h1Style.white,
              ),
              Text(
                "for smart healthcare",
                style: TextStyles.bodySm.white.bold,
              ),
              const Expanded(
                flex: 7,
                child: SizedBox(),
              ),
            ],
          ).alignTopCenter,
        ],
      ),
    );
  }
}
