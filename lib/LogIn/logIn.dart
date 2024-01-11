import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../signUp_pages/doctor_Signup.dart';
import '../signUp_pages/patient_ signUp.dart';
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

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Handle successful login here, you can navigate to another page or perform any other action.

      print('Logged in user: ${userCredential.user!.uid}');
    } catch (e) {
      // Handle login errors
      print('Error during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Container(
                        child: SizedBox(
                          child: Image.asset("lib/assets/logo.png"),
                          height: 28,
                          width: 28,
                        ),
                      )
                    ],
                  ),
                  onPressed: _signInWithEmailAndPassword,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
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
                      builder: (context) => const SignupPage('SignupPage'),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 40,
              child: TextButton(
                child: const Text(
                  "Doctor Sign-Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DoctorSignup('SignupPage'),
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
