import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maaya_tickets/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  BuildContext? ctx;

  void showError(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  void signIn() async {
    var username = usernameController.text;
    var password = passwordController.text;
    final uri = baseUri.replace(path: "/login");
    final resp = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body:
            json.encoder.convert({"user_id": username, "password": password}));
    if (resp.statusCode != 200) {
      final errData = jsonDecode(resp.body);
      final errorString = errData["error"];
      showError(errorString);
    } else {
      final res = jsonDecode(resp.body);
      token = res["token"];
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed("/dashboard");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                  labelText: "userid", border: OutlineInputBorder()),
              controller: usernameController,
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: TextField(
                decoration: const InputDecoration(
                    labelText: "password", border: OutlineInputBorder()),
                controller: passwordController,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: ElevatedButton(onPressed: signIn, child: const Text("Sign In")),
            )
          ],
        ),
      ),
    );
  }
}
