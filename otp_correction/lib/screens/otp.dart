
import 'package:delivery/screens/restaurant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';


class OTPScrn extends StatefulWidget {
  final String ph_num;
  final verificationId;
  const OTPScrn(
      {super.key, required this.ph_num, required this.verificationId, required bool isLogin});

  @override
  State<OTPScrn> createState() => _OTPScrnState();
}
class _OTPScrnState extends State<OTPScrn> {
  final storage = const FlutterSecureStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  final otpController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("OTP Verification"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Enter otp sent to ${widget.ph_num} "),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: otpController,
                maxLength: 6,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'OTP',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: otpController.text);

                  // Sign the user in (or link) with the credential
                  await auth.signInWithCredential(credential);

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("isLogin", true);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const ResPg()));
                } catch (e) {
                  showToast(context, "Invalid OTP. Please try again.");
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Verify"),
            )
          ],
        ));
  }
}
