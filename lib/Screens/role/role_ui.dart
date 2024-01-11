import 'package:flutter/material.dart';

import '../signUp_pages/Pharmacy_SignUp.dart';
import '../signUp_pages/doctor_Signup.dart';
import '../signUp_pages/patient_ signUp.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Role'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Image.asset("lib/assets/logo.png"),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Patient screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage("")),
                );
              },
              child: const ListTile(
                title: Text('Patient'),
                leading: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Doctor screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DoctorSignup("")),
                );
              },
              child: const ListTile(
                title: Text('Doctor'),
                leading: Icon(Icons.medical_services),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Pharmacist screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Pharmacy_SignUp("")),
                );
              },
              child: const ListTile(
                title: Text('Pharmacist'),
                leading: Icon(Icons.local_pharmacy),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
