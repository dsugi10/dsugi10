
// import 'package:delivery/screens/login.dart';
// import 'package:delivery/screens/restaurant.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // Show a loading indicator while checking authentication state
//         } else if (snapshot.hasData) {
//           return ResPg(); // User is authenticated, navigate to the home screen
//         } else {
//           return LoginPg(); // User is not authenticated, navigate to the login screen
//         }
//       },
//     );
//   }
// }