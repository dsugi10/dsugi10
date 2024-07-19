


import 'package:delivery/screens/map.dart';
import 'package:delivery/screens/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';


class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  Future<bool> _onWillPop() async {
    Get.offAll(const ResPg());
    return false; // Prevents the default back button behavior
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const SizedBox(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height:150,
                width:150,
                child: Image.asset("assets/tick.png")),
                 const SizedBox(height: 30),
              const Text("Order Placed Successfully"),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                   
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MapPg()));
                },
                child: const Text("Track Order"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
