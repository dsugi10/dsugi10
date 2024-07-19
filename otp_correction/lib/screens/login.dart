
// import 'package:delivery/provider/prov.dart';
// import 'package:delivery/screens/otp.dart';
// import 'package:delivery/screens/signup.dart';
// import 'package:delivery/utils/utils.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginPg extends StatefulWidget {
//   const LoginPg({super.key});

//   @override
//   State<LoginPg> createState() => _LoginPgState();
// }

// class _LoginPgState extends State<LoginPg> {
//   final mobController = TextEditingController();
//   String completePhoneNumber = '';
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     final authCtrl = Provider.of<AuthProv>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Login"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               IntlPhoneField(
//                 controller: mobController,
//                 flagsButtonPadding: const EdgeInsets.all(8),
//                 dropdownIconPosition: IconPosition.trailing,
//                 decoration: const InputDecoration(
//                   labelText: 'Phone Number',
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(),
//                   ),
//                 ),
//                 initialCountryCode: 'IN',
//                 onChanged: (phone) {
//                   setState(() {
//                     completePhoneNumber = phone.completeNumber;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   SharedPreferences prefs = await SharedPreferences.getInstance();
//                 prefs.setBool("isLogin", true);
//                 setState(() {
//                   isLoading = true;
//                 });

//                   final res =
//                       await authCtrl.checkReg(context, mobController.text);
//                   if (res == "Success") {
//                     await FirebaseAuth.instance.verifyPhoneNumber(
//                       phoneNumber: completePhoneNumber,
//                       verificationCompleted:
//                           (PhoneAuthCredential credential) {},
//                       verificationFailed: (FirebaseAuthException e) {},
//                       codeSent: (String verificationId, int? resendToken) {
                       

//                         Get.to(OTPScrn(
//                                   ph_num: completePhoneNumber,
//                                   verificationId: verificationId,
//                                 ));
//                       },
//                       codeAutoRetrievalTimeout: (String verificationId) {},
//                     );
//                   } else {
//                     showToast(context, res);
//                   }
//                 },
//                 child: isLoading
//                     ? const CircularProgressIndicator()
//                     : const Text("Send OTP"),
//               ),
//               const SizedBox(height:16.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don't have an account"),
//                   TextButton(
//                       onPressed: () {
//                         // Navigator.of(context).push(MaterialPageRoute(
//                         //     builder: (context) => const SignUp()));
//                         Get.to(const SignUp());
//                       },
//                       child: const Text("Sign Up"))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:delivery/provider/prov.dart';
import 'package:delivery/screens/otp.dart';
import 'package:delivery/screens/signup.dart';
import 'package:delivery/utils/utils.dart';

class LoginPg extends StatefulWidget {
  const LoginPg({Key? key}) : super(key: key);

  @override
  State<LoginPg> createState() => _LoginPgState();
}
class _LoginPgState extends State<LoginPg> {
  final mobController = TextEditingController();
  String completePhoneNumber = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authCtrl = Provider.of<AuthProv>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });

                        final res =
                            await authCtrl.checkReg(context, mobController.text);
                        if (res == "Success") {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: completePhoneNumber,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent: (String verificationId, int? resendToken) {
                              Get.to(OTPScrn(
                                ph_num: completePhoneNumber,
                                verificationId: verificationId,
                                isLogin: true,
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
                      },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Send OTP"),
              ),
              const SizedBox (height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account"),
                  TextButton(
                      onPressed: () {
                        Get.to(const SignUp());
                      },
                      child: const Text("Sign Up"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
