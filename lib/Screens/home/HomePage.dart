import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wellness/model/dactor_model.dart';
import 'package:wellness/model/data.dart';
import 'package:wellness/theme/extention.dart';
import 'package:wellness/theme/light_color.dart';
import 'package:wellness/theme/text_styles.dart';
import 'package:wellness/theme/theme.dart';

import '../../helper/shared_pref.dart';
import 'category_list.dart';

class HomePage extends StatefulWidget {
  HomePage({key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<DoctorModel> doctorDataList;
  Map<String, dynamic>? userData;
  Future<void> loadUserData() async {
    userData = await SharedPreferencesHelper.getUserData();

    if (userData != null) {
      // Use userData as needed
      print("User Role: ${userData!['role']}");
      print("User Name: ${userData!['firstName']} ${userData!['lastName']}");
    } else {
      print("User data not found in SharedPreferences");
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    doctorDataList = doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
    super.initState();
    loadUserData();
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: const Icon(
        Icons.short_text,
        size: 30,
        color: Colors.black,
      ),
      actions: <Widget>[
        const Icon(
          Icons.notifications_none,
          size: 30,
          color: LightColor.grey,
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          child: Container(
            // height: 40,
            // width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: Image.asset("lib/assets/user.png", fit: BoxFit.fill),
          ),
        ).p(8),
      ],
    );
  }

  Widget _header() {
    String userName = "User"; // Default value

    if (userData != null) {
      String firstName = userData!['firstName'] ?? "";
      String lastName = userData!['lastName'] ?? "";
      userName = "$firstName $lastName";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello,", style: TextStyles.title.subTitleColor),
        Text(userName, style: TextStyles.h1Style),
      ],
    ).p16;
  }

  Widget _searchField() {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightColor.grey.withOpacity(.3),
            blurRadius: 15,
            offset: const Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyles.body.subTitleColor,
            suffixIcon: SizedBox(
                width: 50,
                child: const Icon(Icons.search, color: LightColor.purple)
                    .alignCenter
                //  .ripple(() {}, borderRadius: BorderRadius.circular(13))),
                )),
      ),
    );
  }

  Widget _doctorsList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Top Doctors", style: TextStyles.title.bold),
              IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {})
              // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ).hP16,
          getdoctorWidgetList()
        ],
      ),
    );
  }

  Widget getdoctorWidgetList() {
    return Column(
        children: doctorDataList.map((x) {
      return _doctorTile(x);
    }).toList());
  }

  Widget _doctorTile(DoctorModel model) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 10,
              color: LightColor.grey.withOpacity(.2),
            ),
            BoxShadow(
              offset: const Offset(-3, 0),
              blurRadius: 15,
              color: LightColor.grey.withOpacity(.1),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: randomColor(),
                ),
                child: Image.asset(
                  model.image,
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: Text(model.name, style: TextStyles.title.bold),
            subtitle: Text(
              model.type,
              style: TextStyles.bodySm.subTitleColor.bold,
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
        // .ripple(() {
        //   Navigator.pushNamed(context, "/DetailPage", arguments: model);
        // }, borderRadius: const BorderRadius.all(Radius.circular(20))),
        );
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50), child: _appBar()),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _header(),
                _searchField(),
                CategoryList(),
              ],
            ),
          ),
          _doctorsList()
        ],
      ),
    );
  }
}
