import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreenPostApiRegister extends StatefulWidget {
  const HomeScreenPostApiRegister({super.key});

  @override
  State<HomeScreenPostApiRegister> createState() => _HomeScreenPostApiRegisterState();
}

class _HomeScreenPostApiRegisterState extends State<HomeScreenPostApiRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, password) async {
    try {
      Response apiResponse =
          await post(Uri.parse("https://reqres.in/api/register"), body: {
        "email": email,
        "password": password,
      });
      if (apiResponse.statusCode == 200) {
        var data = jsonDecode(apiResponse.body.toString());
        print(data["token"]);
        print(data["id"]);
        print("Registered Successfully");
      } else {
        print("Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: "Enter email here",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              hintText: "Enter password here",
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        InkWell(
          onTap: () {
            login(emailController.text.toString(),
                passwordController.text.toString());
          },
          child: Container(
            width: 200,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.purple),
            child: const Center(
                child: Text(
              "Sign Up",
              style: TextStyle(color: Colors.white),
            )),
          ),
        )
      ],
    ));
  }
}
