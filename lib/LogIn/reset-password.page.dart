import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 0, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset("lib/assets/logo.png"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Forgot your password?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please enter the email associated with your account and we will send you a link with instructions for restoring your password.",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
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
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
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
                              "Send",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
