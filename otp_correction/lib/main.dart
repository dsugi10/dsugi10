import 'dart:io';


import 'package:delivery/config/apiconfig.dart';
import 'package:delivery/provider/prov.dart';
import 'package:delivery/screens/login.dart';
import 'package:delivery/screens/restaurant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs= await SharedPreferences.getInstance();
  
  bool isLogin=prefs.getBool('isLogin')??false;

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyBE78jXvvMPVqmbLH8whdPydBiRDj7xYKE",
              appId: "1:61429957213:android:9456d4cd175c997d2483b4",
              messagingSenderId: "61429957213",
              projectId: "delivery-c2c8d"))
      : await Firebase.initializeApp();
  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp({super.key, required this.isLogin});


  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: ApiConfig.getLink(),
        child: ChangeNotifierProvider(
          create: (context) => AuthProv(),
          child:  GetMaterialApp(
              debugShowCheckedModeBanner: false, 
              home: isLogin ? const ResPg(): const LoginPg()
              ),
        ));
  }

 
  }




