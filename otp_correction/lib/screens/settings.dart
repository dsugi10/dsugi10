import 'dart:developer';

import 'package:delivery/provider/prov.dart';
import 'package:delivery/screens/login.dart';
import 'package:delivery/screens/restaurant.dart';
import 'package:delivery/utils/utils.dart';
import 'package:delivery/widgets/textinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  final String mobilenum;
  final String? id;
  final String username;
  const Settings(
      {super.key, required this.mobilenum, this.id, required this.username});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final storage = const FlutterSecureStorage();

  final nameController = TextEditingController();
  final mobController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.username;
    mobController.text = widget.mobilenum;

    log("user ${nameController.text}............mob ${mobController.text}");
    loadPassword();
  }

  Future<void> loadPassword() async {
    String? username = await storage.read(key: 'username');

    String? mobileNum = await storage.read(key: "mob");

    log("user22222 $username............mob22222222 $mobileNum");
    setState(() {
      nameController.text = username ?? '';

      mobController.text = mobileNum ?? '';
    });
  }

  @override
  void dispose() {
    nameController.dispose();

    mobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCtrl = Provider.of<AuthProv>(context);
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Settings"),
          actions: [
            TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content:
                            const Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();
                              await storage.deleteAll();
                              Get.offAll(const LoginPg());
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text("Log Out"))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFieldInput(
                textEditingController: nameController,
                hintText: "User Name",
                textInputType: TextInputType.name,
                readOnly: true,
              ),
              const SizedBox(height: 30),
              TextFieldInput(
                  textEditingController: mobController,
                  hintText: "Mobile Number",
                  textInputType: TextInputType.phone,
                  maxLength:10
                  ),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () async {
                    log("userrrrrr ${nameController.text}");
                    log("mobbnummm: ${mobController.text}");

                    final result = await authCtrl.userEdit(widget.id,
                        mobController.text, nameController.text, context);
                    if (result == "Updated Successfully") {
                      showToast(context, result);
                      Get.offAll(const ResPg());
                    } else {
                      showToast(context, result);
                    }
                  },
                  child: const Text("Save"))
            ],
          ),
        ));
  }
}
