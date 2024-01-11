import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wellness/Screens/LogIn/logIn.dart';

class DoctorSignup extends StatefulWidget {
  const DoctorSignup(String s, {Key? key}) : super(key: key);

  @override
  _DoctorSignupState createState() => _DoctorSignupState();
}

class _DoctorSignupState extends State<DoctorSignup> {
  @override
  void initState() {
    // get data from database   use var data

    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool hidePassword = true;
  bool hidePasswordCon = true;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController doctorIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController specialtyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // TextEditingController conPasswordController = TextEditingController();
  Future<void> _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Save additional user information to Firestore
      await _firestore.collection('doctors').doc(userCredential.user!.uid).set({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'doctorId': doctorIdController.text,
        'specialty': specialtyController.text,
        'phoneNumber': phoneNumberController.text,
        'role': 2 // Role Doctor
      });
      print("okkkkkkkkkkkkkkkkk");
      // Navigate to the next screen or perform other actions after registration
    } catch (e) {
      // Handle registration errors
      print("onnnnnnnnnnnnnnnnnnnnnnnnnnnnkkkkkkkkkkk");

      print(e.toString());
    }
  }

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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/logo.png"),
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
                    // autofocus: true,
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
                const SizedBox(width: 10), // Add space between text fields
                Expanded(
                  child: TextField(
                    controller: lastNameController,
                    // autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      // suffixIcon: Icon(Icons.account_circle),
                      // suffixIconColor:Theme.of(context).colorScheme.onPrimary,
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
              // autofocus: true,
              controller: doctorIdController,
              obscureText: hidePasswordCon,
              keyboardType: TextInputType.number,
              // obscureText: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_card),
                  onPressed: () {},
                ),
                suffixIconColor: Theme.of(context).colorScheme.onPrimary,
                labelText: "Doctor ID",
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
              controller: emailController,
              // autofocus: true,
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
              controller: specialtyController,

              // autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.add),
                suffixIconColor: Theme.of(context).colorScheme.onPrimary,
                labelText: "Doctor's specialty",
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
              // autofocus: true,
              controller: passwordController,
              obscureText: hidePassword,
              keyboardType: TextInputType.visiblePassword,
              // obscureText: true,
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
              // autofocus: true,
              controller: confirmPasswordController,
              obscureText: hidePasswordCon,
              keyboardType: TextInputType.visiblePassword,
              // obscureText: true,
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
                  onPressed: _register,
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
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
                        builder: (context) => const LoginPage(''),
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
}
