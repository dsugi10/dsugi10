import 'package:delivery/provider/prov.dart';
import 'package:delivery/screens/otp.dart';
import 'package:delivery/utils/utils.dart';
import 'package:delivery/widgets/textinput.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  String completePhoneNumber = '';
  final storage = const FlutterSecureStorage();
  final userController = TextEditingController();
  final mobController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    userController.dispose();
    mobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCtrl = Provider.of<AuthProv>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldInput(
                    textEditingController: userController,
                    hintText: "Enter your Username",
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(height: 30),
                  IntlPhoneField(
                    controller: mobController,
                    flagsButtonPadding: const EdgeInsets.all(8),
                    dropdownIconPosition: IconPosition.trailing,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      setState(() {
                        completePhoneNumber = phone.completeNumber;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      final res =
                          await authCtrl.checkNum(context, mobController.text);
                      if (res == "This mobile number is already registered") {
                        showToast(context, res);
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        final res = await authCtrl.newUser(
                            context, userController.text, mobController.text);
                        if (res == "Inserted Successfully") {
                          showToast(context, res);
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: completePhoneNumber,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent: (String verificationId, int? resendToken) {
                              Get.to(OTPScrn(
                                ph_num: completePhoneNumber,
                                verificationId: verificationId,
                                isLogin: false,
                              ));
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                          );
                        } else {
                          showToast(context, res);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Send OTP"),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account"),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
