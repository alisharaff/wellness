import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../role/role_ui.dart';
import '../signUp_pages/doctor_Signup.dart';
import 'reset-password.page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(String s, {Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool hidePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Handle successful login here, you can navigate to another page or perform any other action.
      DocumentSnapshot<Map<String, dynamic>?> doctorSnapshot = await _firestore
          .collection('doctors')
          .doc(userCredential.user!.uid)
          .get();

      // Save data in shared preferences
      _saveDataInSharedPreferences(doctorSnapshot.data());

      print(
          'Logged in user: ${userCredential.user!.uid}'); // Show a snackbar for successful login
      _showSnackbar("Login Successful", Colors.green);
    } catch (e) {
      // Handle login errors
      print('Error during login: $e');
      // Show a snackbar for login failure
      // Fetch additional data from Firestore

      _showSnackbar("Login failed. Please check your credentials.", Colors.red);
    }
  }

  Future<void> _saveDataInSharedPreferences(
      Map<String, dynamic>? userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstName', userData?['firstName']);
    prefs.setString('lastName', userData?['lastName']);
    prefs.setString('doctorId', userData?['doctorId']);
    prefs.setString('specialty', userData?['specialty']);
    prefs.setString('phoneNumber', userData?['phoneNumber']);
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 300,
              child: Image.asset("lib/assets/logo.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.mail),
                suffixIconColor: Theme.of(context).colorScheme.onPrimary,
                labelText: "E-mail",
                labelStyle: const TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
                suffixIconColor: Theme.of(context).colorScheme.onPrimary,
                labelText: "Password",
                labelStyle: const TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: const Text(
                  "Forgot your password?",
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 40,
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
                child: ElevatedButton(
                  onPressed: _signInWithEmailAndPassword,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 28,
                        width: 12,
                      ),
                      SizedBox(
                        child: Image.asset("lib/assets/logo.png"),
                        height: 28,
                        width: 28,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextButton(
                child: const Text(
                  "Sign-Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChooseRoleScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
