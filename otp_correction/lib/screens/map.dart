import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:delivery/provider/prov.dart';
import 'package:delivery/screens/restaurant.dart';

class MapPg extends StatefulWidget {
  const MapPg({Key? key}) : super(key: key);

  @override
  State<MapPg> createState() => _MapPgState();
}

class _MapPgState extends State<MapPg> {
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final authCtrl = Provider.of<AuthProv>(context);
    final procart = Provider.of<AuthProv>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Order Tracking"),
      ),
      body: FutureBuilder<List<String>>(
        future: readData(), // Call readData asynchronously
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<String>? img = snapshot.data; // Access data from snapshot
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/track.png",
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Delivery Info",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text("Order will be delivered in 35 mins"),
                      Text("To:"),
                      Text(authCtrl.storeAdd),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Cart Items",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 300, // Fixed height for the container
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: img?.length ?? 0, // Use img list here
                          itemBuilder: (context, index) {
                            final cartItem = img![index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        cartItem,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 57.5,
                    width: double.infinity,
                    color: Colors.deepPurple,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          procart.cartImg.clear();
                          log('mapCartImages..........${procart.cartImg}');
                          Get.offAll(ResPg());
                        },
                        child: const Text(
                          "Continue Shopping",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Future<List<String>> readData() async {
    var name = await storage.read(key: "name");
    var address = await storage.read(key: "adr");
    var type = await storage.read(key: "adrType");

    log("name: $name, address: $address, type: $type");

    String? jsonString = await storage.read(key: "Img");
    List<String> img = jsonString != null ? List<String>.from(jsonDecode(jsonString)) : [];
    log("Cart product Images: $img");

    return img; // Return the list of images
  }
}












