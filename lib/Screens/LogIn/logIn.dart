import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/patient/HomePage.dart';
import '../role/role_ui.dart';
import 'reset-password.page.dart';

class LoginPage extends StatefulWidget {
  final int role;
  const LoginPage({Key? key, required this.role}) : super(key: key);

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
  bool _loading = false;
  Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (widget.role == 1) {
        DocumentSnapshot<Map<String, dynamic>?> doctorSnapshot =
            await _firestore
                .collection('patients')
                .doc(userCredential.user!.uid)
                .get();
        print(doctorSnapshot.data());
        _saveDataInSharedPreferences(doctorSnapshot.data());
      } else if (widget.role == 2) {
        DocumentSnapshot<Map<String, dynamic>?> doctorSnapshot =
            await _firestore
                .collection('doctors')
                .doc(userCredential.user!.uid)
                .get();
        print(doctorSnapshot.data());
        _saveDataInSharedPreferences(doctorSnapshot.data());
      } else {
        DocumentSnapshot<Map<String, dynamic>?> doctorSnapshot =
            await _firestore
                .collection('pharmacies')
                .doc(userCredential.user!.uid)
                .get();
        print(doctorSnapshot.data());
        _saveDataInSharedPreferences(doctorSnapshot.data());
      }
      print('Logged in user: ${userCredential.user!.uid}');
      setState(() {
        _loading = true; // Set loading to true
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      _showSnackbar("Login Successful", Colors.green);
    } catch (e) {
      // Handle login errors
      print('Error during login: $e');

      _showSnackbar("Login failed. Please check your credentials.", Colors.red);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _saveDataInSharedPreferences(
      Map<String, dynamic>? userData) async {
    print("============================");
    print(userData);
    print(userData?["role"]);
    print("============================");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstName', userData?['firstName'] ?? "");
    prefs.setString('lastName', userData?['lastName'] ?? "");
    prefs.setString('Id', userData?['Id'] ?? "");
    prefs.setString('specialty', userData?['specialty'] ?? "");
    prefs.setString('phoneNumber', userData?['phoneNumber'] ?? "");

    // Adding a null check before storing the 'role' value
    if (userData?["role"] != null) {
      prefs.setString('role', userData!["role"].toString());
      print(prefs.getString('role'));
    } else {
      print("Role is null");
    }
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
              child: _loading
                  ? CircularProgressIndicator() // Show loading indicator
                  : SizedBox.expand(
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
