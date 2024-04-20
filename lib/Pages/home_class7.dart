import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class HomeScreenPostApiLogin extends StatefulWidget {
  const HomeScreenPostApiLogin({super.key});

  @override
  State<HomeScreenPostApiLogin> createState() => _HomeScreenPostApiLoginState();
}

class _HomeScreenPostApiLoginState extends State<HomeScreenPostApiLogin> {
  //creates controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  login(String email, password) async {
    try {
      Response apiResponse =
          await post(Uri.parse("https://reqres.in/api/login"),
           body:{
            "email":email,
            "password":password,
          }
          );
      if (apiResponse.statusCode == 200) {
        var data = jsonDecode(apiResponse.body.toString());
        print(data["token"]);
        print("User Login Successfully");
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
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purple),
              child: const Center(
                  child: Text(
                "Sign In",
                style: TextStyle(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
