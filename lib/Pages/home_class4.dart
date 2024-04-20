import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenClass4 extends StatefulWidget {
  const HomeScreenClass4({super.key});

  @override
  State<HomeScreenClass4> createState() => _HomeScreenClass4State();
}

class _HomeScreenClass4State extends State<HomeScreenClass4> {
  /*
  In this class we will build list with complex json data without model.
  So, let's get started
   */

  var jsonData;
  Future<void> getUserApi() async {
    final apiResponse =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    jsonData = jsonDecode(apiResponse.body.toString());
    if (apiResponse.statusCode == 200) {
      return jsonData;
    } else {
      return jsonData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Loading"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: jsonData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReusableWidget(
                                  title: "Name: ",
                                  value: jsonData[index]['name'].toString()),
                              ReusableWidget(
                                  title: "City: ",
                                  value: jsonData[index]['address']['city']
                                      .toString()),
                              ReusableWidget(
                                  title: "Geo: ",
                                  value: jsonData[index]['address']['geo']['lat']
                                      .toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableWidget extends StatelessWidget {
  String title, value;
  ReusableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
