import 'dart:developer';

import 'package:delivery/menuDetails/menu.dart';
import 'package:delivery/model/rescls.dart';
import 'package:delivery/screens/menuCatpg.dart';
import 'package:delivery/screens/settings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ResPg extends StatefulWidget {
  const ResPg({
    super.key,
  });

  @override
  State<ResPg> createState() => _ResPgState();
}

class _ResPgState extends State<ResPg> {
  final storage = const FlutterSecureStorage();
  String username = '';
  String mobNum = '';
  String id = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    String? storedUsername = await storage.read(key: 'username');
    String? mobileNum = await storage.read(key: "mob");

    log("STusername: ${storedUsername}");
    log("STMob: ${mobileNum}");

    setState(() {
      username = storedUsername ?? '';
      mobNum = mobileNum ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Restaurant> reslist =
        menu[0]["restaurants"].map<Restaurant>((restaurant) {
      return Restaurant.fromMap(restaurant);
    }).toList();

    log("res names : $reslist");

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Welcome"),
          actions: [
            IconButton(
                onPressed: () async {
                  id = (await storage.read(key: 'UpID'))!;
                  log("RRRidddd: $id");

                  id = (await storage.read(key: "UpID"))!;
                  log("LLLLLId: $id");

                  id = (await storage.read(key: "UpID"))!;
                  log("MMMMMId: $id");

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Settings(
                            id: id,
                            username: username,
                            mobilenum: mobNum,
                          )));
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: reslist.length,
              itemBuilder: (context, index) {
                Restaurant restName = reslist[index];
                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Get.to(MenuCat(
                          restaurantName: restName.name,
                          menulist: restName.menu,
                        ));
                      },
                      trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      leading: SizedBox(
                        height: 120,
                        width: 120,
                        child: Image.asset(
                          restName.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            restName.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4.0),
                          Text(restName.address),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
