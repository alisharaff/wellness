import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness/Screens/home/patient/appointment.dart';
import 'package:wellness/Screens/home/patient/profile.dart';
import 'package:wellness/model/dactor_model.dart';
import 'package:wellness/model/data.dart';
import 'package:wellness/theme/extention.dart';
import 'package:wellness/theme/light_color.dart';
import 'package:wellness/theme/text_styles.dart';

import '../../../helper/shared_pref.dart';
import '../../../navPages/profile_ pages/patient_profile.dart';
import 'widgets/app_bar.dart';
import 'widgets/category_list.dart';
import 'widgets/search_field.dart';

class HomePage extends StatefulWidget {
  HomePage({key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<DoctorModelHome> doctorDataList;
  Map<String, dynamic>? userData;

  int _selectedIndex = 0;
  Future<void> fetchDoctorDetails() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('doctors').get();

      setState(() {
        doctorDataList = snapshot.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
          print('${doc['firstName'] + doc['lastName']}');
          return DoctorModelHome(
            id: doc['Id'] ?? " ",
            name: '${doc['firstName'] + doc['lastName']}' ?? " ",
            type: doc['specialty'] ?? "",
          );
        }).toList();
      });
    } catch (e) {
      print('Error fetching doctor details: $e');
    }
  }

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
    doctorDataList =
        doctorMapList.map((x) => DoctorModelHome.fromJson(x)).toList();
    super.initState();
    loadUserData();
    fetchDoctorDetails();
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

  Widget _doctorTile(DoctorModelHome model) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/DetailPage", arguments: model);
      },
      child: Container(
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
                    "lib/assets/doctor.png",
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
          )),
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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppBar(),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Screen 1
          CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _header(),
                    SearchField(),
                    CategoryList(),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _doctorTile(doctorDataList[index]);
                  },
                  childCount: doctorDataList.length,
                ),
              ),
            ],
          ),

          AppointmentsScreen(paId : userData!['Id']),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
