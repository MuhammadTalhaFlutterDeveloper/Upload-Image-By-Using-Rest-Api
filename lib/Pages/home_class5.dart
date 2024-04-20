import 'dart:convert';

import 'package:api2024/Models/json_model_class5.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenClass5 extends StatefulWidget {
  const HomeScreenClass5({super.key});

  @override
  State<HomeScreenClass5> createState() => _HomeScreenClass5State();
}

class _HomeScreenClass5State extends State<HomeScreenClass5> {
  Future<ProductsModel> getProductsApi() async {
    //create your own api
    final response = await http.get(
        Uri.parse('https://webhook.site/d24f9761-dfba-4759-bcda-f42f3dd539b7'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Class-5"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<ProductsModel>(
            future: getProductsApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(snapshot.data!.data![index].shop!.name
                                .toString()),
                            subtitle: Text(snapshot
                                .data!.data![index].shop!.shopemail
                                .toString()),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot
                                  .data!.data![index].shop!.image
                                  .toString()),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * 1,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.data![index].images!.length,
                                itemBuilder: (context, position) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .25,
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(snapshot
                                                  .data!
                                                  .data![index]
                                                  .images![position]
                                                  .url
                                                  .toString()))),
                                    ),
                                  );
                                }),
                          ),
                          Icon(snapshot.data!.data![index].inWishlist! == false
                              ? Icons.favorite
                              : Icons.favorite_outline)
                        ],
                      );
                    });
              } else {
                return const Center(child: Text('Loading'));
              }
            },
          ))
        ],
      ),
    );
  }
}
