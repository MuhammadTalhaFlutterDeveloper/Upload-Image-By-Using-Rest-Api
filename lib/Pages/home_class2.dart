import 'dart:convert';

import 'package:api2024/Models/json_model_class2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenClass2 extends StatefulWidget {
  const HomeScreenClass2({super.key});

  @override
  State<HomeScreenClass2> createState() => _HomeScreenClass2State();
}

class _HomeScreenClass2State extends State<HomeScreenClass2> {
  //create a list to add photos
  List<PhotosModel> photosModel = [];
  //hit api from here
  Future<List<PhotosModel>> getPhotosApi() async {
    final apiResponse = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var jsonData = jsonDecode(apiResponse.body.toString());
    if (apiResponse.statusCode == 200) {
      for (dynamic i in jsonData) {
        photosModel.add(PhotosModel.fromJson(i));
      }
      return photosModel;
    } else {
      return photosModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('API Class-2'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotosApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: photosModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data![index].url.toString()),
                        ),
                        trailing: Text(snapshot.data![index].id.toString()),
                        title: Text("Title: ${snapshot.data![index].title}"),
                        subtitle: Text(
                            "thumbnail url: ${snapshot.data![index].thumbnailUrl}"),
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