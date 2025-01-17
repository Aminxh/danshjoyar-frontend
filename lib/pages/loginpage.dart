import 'package:danshjoyar/mainPageHandler.dart';
import 'package:danshjoyar/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  bool userCanLogin = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "lib/asset/images/alex-shutin-kKvQJ6rK6S4-unsplash.jpg"),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
        padding: EdgeInsets.fromLTRB(height / 25, height / 25, height / 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "lib/asset/images/Sbu-logo.svg.png",
              scale: MediaQuery.of(context).size.width / 60,
              filterQuality: FilterQuality.high,
            ),
            TextField(
              controller: usernameController,
              cursorColor: Colors.cyan,
              style: TextStyle(fontSize: 20, color: Colors.white70),
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                hintText: 'Enter your username',
                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
                icon: Icon(Icons.account_circle_sharp, size: 35,),
                iconColor: Colors.white,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: !_passwordVisible,
              style: TextStyle(fontSize: 20, color: Colors.white70),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
                hintText: 'Enter your password',
                hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white70),
                icon: const Icon(Icons.key, size: 35,),
                iconColor: Colors.white,
                suffixIcon: IconButton(
                  splashColor: Colors.white,
                  tooltip: "Change visibility",
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).dialogBackgroundColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.black12,
              ),
              onPressed: () async {
                String username = usernameController.text;
                String password = passwordController.text;
                bool canLogin = await loginChecker(username, password);
                if (canLogin) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        mainPageHandler(username: username, password: password)),
                  );
                } else {
                  error();
                }
              },
              child: const Text('Login',
                  style: TextStyle(
                    letterSpacing: 3.5,
                    color: Colors.cyan,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------

  Future<bool> loginChecker(String username, String password) async {
    String userData = username + "~" + password;
    Completer<bool> completer = Completer();
    Socket.connect("172.28.0.1", 7777).then((serverSocket) {
      serverSocket.write('LOGIN~$userData\u0000');
      serverSocket.flush();
      serverSocket.listen((socketResponse) {
        String userExist = String.fromCharCodes(socketResponse).trim();
        if (userExist == "true") {
          completer.complete(true);
        } else {
          completer.complete(false);
        }
        serverSocket.destroy();
      });
    });
    return completer.future;
  }

  // ---------------------------------------------------------------------------

  void error() {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 7),
      title: const Text("Invalid Password"),
      description: Text("Your password or username is invalid"),
      alignment: Alignment.topCenter,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(Icons.error),
      primaryColor: Colors.red,
      backgroundColor: Colors.black54,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      borderRadius: BorderRadius.circular(30),
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.always,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }
}
