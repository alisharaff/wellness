import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../LogIn/logIn.dart';

class SignupPage extends StatefulWidget {
  const SignupPage(String s, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool hidePassword = true;
  bool hidePasswordCon = true;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              alignment: const Alignment(0.0, 1.15),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: const AssetImage("lib/assets/logo.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: Container(
                height: 56,
                width: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1.0],
                    colors: [
                      Color(0xFF06413d),
                      Color(0XFF12a299),
                    ],
                  ),
                  border: Border.all(
                    width: 4.0,
                    color: const Color(0xFFFFFFFF),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(56),
                  ),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    controller: firstNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "First Name",
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: idNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_card),
                  onPressed: () {},
                ),
                suffixIconColor: Theme.of(context).colorScheme.onPrimary,
                labelText: "ID Number",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: mailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.mail),
                suffixIconColor: Theme.of(context).colorScheme.onPrimary,
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              obscureText: hidePassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
                suffixIconColor: Theme.of(context).colorScheme.onPrimary,
                labelText: "Password",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: hidePasswordCon,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(hidePasswordCon
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      hidePasswordCon = !hidePasswordCon;
                    });
                  },
                ),
                suffixIconColor: Theme.of(context).colorScheme.onPrimary,
                labelText: "Confirm Password",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            IntlPhoneField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: "Phone Number",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                print(phone.completeNumber);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
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
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    // Call the method to register and save data
                    _registerAndSaveData();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 35,
                child: TextButton(
                  child: const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(role: 1),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registerAndSaveData() async {
    try {
      // Register user with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mailController.text,
        password: passwordController.text,
      );

      // Save additional user information to Firestore
      await _firestore
          .collection('patients')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'Id': idNumberController.text,
        'email': mailController.text,
        'phoneNumber': phoneNumberController.text,
        'role': 1 // Patient role
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(
            role: 1,
          ),
        ),
      );
      print("Registration successful!");
    } catch (e) {
      // Handle registration errors
      print("Registration error: $e");
    }
  }
}
