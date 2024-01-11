import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  final String SettingType; // Add a parameter for the profile type

  const SettingPage(this.SettingType, {super.key}); // Constructor with a required parameter


  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
