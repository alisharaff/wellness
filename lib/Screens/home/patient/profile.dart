import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController doctorIdController = TextEditingController();
  TextEditingController specialtyController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController registrationDateController = TextEditingController();

  @override
  void initState() {
    loadUserProfile();
    super.initState();
  }

  Future<void> loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstNameController.text = prefs.getString('firstName') ?? '';
      lastNameController.text = prefs.getString('lastName') ?? '';
      doctorIdController.text = prefs.getString('doctorId') ?? '';
      specialtyController.text = prefs.getString('specialty') ?? '';
      phoneNumberController.text = prefs.getString('phoneNumber') ?? '';
      roleController.text = prefs.getString('role') ?? '';
      registrationDateController.text =
          prefs.getString('registrationDate') ?? '';
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Clear user data from shared preferences
    await prefs.clear();

    // Navigate to login or any other initial screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextField('First Name', firstNameController),
          buildTextField('Last Name', lastNameController),
          buildTextField('Doctor ID', doctorIdController),
          buildTextField('Specialty', specialtyController),
          buildTextField('Phone Number', phoneNumberController),
          buildTextField('Role', roleController),
          SizedBox(height: 20),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => logout(),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
      ),
      controller: controller,
    );
  }
}
