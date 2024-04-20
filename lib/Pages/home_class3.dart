import 'dart:convert';

import 'package:api2024/Models/json_model_class3.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenClass3 extends StatefulWidget {
  const HomeScreenClass3({super.key});

  @override
  State<HomeScreenClass3> createState() => _HomeScreenClass3State();
}

class _HomeScreenClass3State extends State<HomeScreenClass3> {
  //create a list
  List<UsersModel> usersList = [];
  //hit api
  Future<List<UsersModel>> getUsersApi() async {
    final apiResponse =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var jsonData = jsonDecode(apiResponse.body.toString());
    if (apiResponse.statusCode == 200) {
      for (dynamic i in jsonData) {
        usersList.add(UsersModel.fromJson(i));
      }
      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Class-3'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsersApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: usersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReusableWidget(
                                  title: "Name: ",
                                  value: snapshot.data![index].name.toString()),
                              ReusableWidget(
                                  title: "Username: ",
                                  value: snapshot.data![index].username
                                      .toString()),
                              ReusableWidget(
                                  title: "Address: ",
                                  value:
                                      snapshot.data![index].address.toString()),
                              ReusableWidget(
                                  title: "Email: ",
                                  value:
                                      snapshot.data![index].email.toString()),
                                       ReusableWidget(
                                  title: "Phone: ",
                                  value:
                                      snapshot.data![index].phone.toString()),
                              ReusableWidget(
                                  title: "City: ",
                                  value: snapshot.data![index].address!.city
                                      .toString()),
                              ReusableWidget(
                                  title: "Street: ",
                                  value: snapshot.data![index].address!.street
                                      .toString()),
                              ReusableWidget(
                                  title: "Latitude: ",
                                  value: snapshot.data![index].address!.geo!.lat
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
