import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wellness/model/dactor_model.dart';

import '../Screens/home/patient/HomePage.dart';
import '../helper/shared_pref.dart';
import '../helper/show_snackerbar.dart';

class CreatNewDatePage extends StatefulWidget {
  const CreatNewDatePage(String s, {Key? key, required this.model})
      : super(key: key);
  final DoctorModelHome model;
  @override
  State<CreatNewDatePage> createState() => _CreatNewDatePageState();
}

class _CreatNewDatePageState extends State<CreatNewDatePage> {
  //declaration
  Map<String, dynamic>? userData;
  int? _selectedTime;
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? token;

  Future<void> loadUserData() async {
    userData = await SharedPreferencesHelper.getUserData();

    if (userData != null) {
      // Use userData as needed
      print("User Role: ${userData!['role']}");
      print("User Name: ${userData!['firstName']} ${userData!['lastName']}");
      print(userData!['Id']);
    } else {
      print("User data not found in SharedPreferences");
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _saveAppointment() async {
    // Check if both date and time are selected
    if (!_dateSelected || !_timeSelected) {
      print("object");
      return;
    }

    try {
      // Create a reference to the appointments collection in Firestore
      CollectionReference appointments =
          FirebaseFirestore.instance.collection('appointments');

      // Get the patient's user ID from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? patientUserId = prefs.getString('userId');

      // Check if patientUserId is not null (it should have been set during patient login)
      if (userData!['Id'] != null) {
        // Create a new appointment document
        int hour = 9 + (_currentIndex! ~/ 2);
        int minutes = (_currentIndex! % 2) * 30;

        await appointments.add({
          'patientId': userData!['Id'],
          'doctrId': widget.model.id,
          'docterName': widget.model.name,
          'docterType': widget.model.type,
          'date': _currentDay,
          'time':
              '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} ${hour >= 12 ? "PM" : "AM"}',
        });
        showSnackbar(context, "Saving Appointment Successful", Colors.green);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        print('Error: Patient user ID is null.');
        showSnackbar(context,
            "Saving Appointment failed. Please check your data.", Colors.red);
      }
    } catch (e) {
      // Handle any errors that occur during Firestore operation

      showSnackbar(context,
          "Saving Appointment failed. Please check your data.", Colors.red);

      print('Error saving appointment: $e');
    }
  }

  @override
  void initState() {
    // getToken();
    super.initState();
    print(widget.model.id);
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    // Config().init(context);
    // final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white, //background color is white in this app
        elevation: 0,

        title: Text(
          'Appointment',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),

        actions: const [Icon(Icons.arrow_back_ios)],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _tableCalendar(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: Text(
                      'Select Consultation Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(6, 65, 61, 1.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    alignment: Alignment.center,
                    child: const Text(
                      'Weekend is not available, please select another date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      int hour = 9 +
                          (index ~/
                              2); // Calculate hour based on index (9:00 AM to 11:30 PM)
                      int minutes = (index % 2) *
                          30; // Alternate between 0 and 30 minutes

                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            _timeSelected = true;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0XFF12a299),
                            border: Border.all(
                              color: _currentIndex == index
                                  ? Colors.white
                                  : const Color(0XFF12a299),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} ${hour >= 12 ? "PM" : "AM"}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  _currentIndex == index ? Colors.white : null,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount:
                        16, // Displaying 34 half-hour intervals from 9:00 AM to 11:30 PM
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        4, // Adjust the cross-axis count based on the number of desired intervals
                    childAspectRatio: 1.5,
                  ),
                ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
              child: Button(
                width: double.infinity,
                title: 'Make Appointment',
                onPressed: _saveAppointment,
                disable: _timeSelected && _dateSelected ? false : true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //table calendar
  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      formatAnimationCurve: Curves.bounceIn,
      firstDay: DateTime.now(),
      lastDay: DateTime(2024, 1, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0XFF12a299),
          fontSize: 20,
        ),
      ),
      daysOfWeekHeight: 30,
      daysOfWeekStyle: const DaysOfWeekStyle(
        // Set the day format to display only one letter
        weekdayStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0XFF12a299), // Customize color if needed
        ),
        weekendStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF06413d),
        ),
      ),
      weekendDays: const [DateTime.friday],
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: Color(0XFF12a299), shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          //check if weekend is selected
          if (selectedDay.weekday == 5 /* || selectedDay.weekday == 6*/) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      }),
    );
  }
}

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.width,
      required this.title,
      required this.onPressed,
      required this.disable})
      : super(key: key);

  final double width;
  final String title;
  final bool disable; //this is used to disable button
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
          colors: [
            Color(0xFF06413d),
            Color(0XFF12a299),
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: SizedBox.expand(
        child: TextButton(
          onPressed: disable ? null : onPressed,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),

      //   SizedBox(
      //   width: width,
      //
      //   child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: Colors.black38,
      //       foregroundColor: Colors.white,
      //     ),
      //     onPressed: disable ? null : onPressed,
      //     child: Text(
      //       title,
      //       style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white,
      //         fontSize: 20,
      //       ),
      //       textAlign: TextAlign.center,
      //       ),
      //     ),
    );
  }
}
