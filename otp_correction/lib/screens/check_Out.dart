// import 'dart:developer';
// import 'dart:ffi';
// import 'package:delivery/query_mut/query.dart';
// import 'package:delivery/screens/address.dart';
// import 'package:delivery/screens/payment.dart';
// import 'package:delivery/screens/success.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class CheckOut extends StatefulWidget {
//   const CheckOut({super.key});

//   @override
//   State<CheckOut> createState() => _CheckOutState();
// }

// class _CheckOutState extends State<CheckOut> {
//   var a_uid;
//   final storage = const FlutterSecureStorage();
//   int? selectedValue;

//   @override
//   void initState() {
//     super.initState();
//     idAddress();

//   }

//   idAddress() async {
//     a_uid = await storage.read(key: "UpID");
//     log("A_userId_Q: $a_uid");
//     setState(() {}); // Ensure the state is updated after reading the user ID
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Query(
//       options: QueryOptions(
//         document: gql(getAddress),
//         variables: {"user_id": a_uid},
//         cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
//         fetchPolicy: FetchPolicy.noCache,
//       ),
//       builder: (QueryResult result,
//           {VoidCallback? refetch, FetchMore? fetchMore}) {
//         log("ResultAddress: ${result.data}");

//         String userAddress=result.data!['user_address'][0]['address'];
//         String userAdrType=result.data!['user_address'][0]['address_type'];
//         String userName=result.data!['user_address'][0]['name'];

//         if (result.hasException) {
//           log("exception: ${result.exception!.graphqlErrors}");
//           log("linkException: ${result.exception!.linkException}");
//           return Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("No Address added"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => AddressPg()));
//                     },
//                     child: const Text("Click to add Address"),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//         if (result.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         List<dynamic>? userAddressList = result.data?['user_address'];
//         if (userAddressList == null || userAddressList.isEmpty) {
//           return Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text("No Address added"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => AddressPg()));
//                     },
//                     child: const Text("Click to add Address"),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//         List<String> addressTable =
//             userAddressList.map<String>((e) => e['address'] as String).toList();
//              load()  {
//            storage.write(key: "adr", value: userAddress);
//           storage.write(key: "adrType", value: userAdrType);
//            storage.write(key: "name", value: userName);
//         }

//         return Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             title: Text("Select an address"),
//             backgroundColor: Colors.white,
//           ),
//           body: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   if (addressTable.isNotEmpty)
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: addressTable.length,
//                       itemBuilder: (context, index) {
//                         return RadioListTile<int>(
//                           title: Text(addressTable[index]),
//                           value: index,
//                           groupValue: selectedValue,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedValue = value;
//                             });
//                           },
//                         );
//                       },
//                     ),
//                   Flexible(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => AddressPg()));
//                       },
//                       child: const Text("Click to add Address"),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                 ],
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   color: Colors.deepPurple,
//                   height: 60,
//                   width: double.infinity,
//                   child: TextButton(
//                     onPressed: selectedValue != null
//                         ? () {
//                             // Navigate to the Success page or perform checkout actions
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => Payment()));
//                           }
//                         : null,
//                     child: const Text(
//                       "Next",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:developer';
import 'package:delivery/provider/prov.dart';
import 'package:delivery/query_mut/query.dart';
import 'package:delivery/screens/address.dart';
import 'package:delivery/screens/payment.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  var a_uid;
  final storage = const FlutterSecureStorage();
  int? selectedValue;

  @override
  void initState() {
    super.initState();
    idAddress();
  }

  idAddress() async {
    a_uid = await storage.read(key: "UpID");
    log("A_userId_Q: $a_uid");
    setState(() {}); // Ensure the state is updated after reading the user ID
  }

  @override
  Widget build(BuildContext context) {
    final authCtrl = Provider.of<AuthProv>(context);
    return Query(
      options: QueryOptions(
        document: gql(getAddress),
        variables: {"user_id": a_uid},
        cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
        fetchPolicy: FetchPolicy.noCache,
      ),
      builder: (
        QueryResult result, {
        VoidCallback? refetch,
        FetchMore? fetchMore,
      }) {
        log("ResultAddress: ${result.data}");
        authCtrl.userFetch = refetch;

        if (result.hasException) {
          log("exception: ${result.exception!.graphqlErrors}");
          log("linkException: ${result.exception!.linkException}");
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("No Address added"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AddressPg()));
                    },
                    child: const Text("Click to add Address"),
                  ),
                ],
              ),
            ),
          );
        }

        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        List<dynamic>? userAddressList = result.data?['user_address'];
        if (userAddressList == null || userAddressList.isEmpty) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("No Address added"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AddressPg()));
                    },
                    child: const Text("Click to add Address"),
                  ),
                ],
              ),
            ),
          );
        }

        List<String> addressTable =
            userAddressList.map<String>((e) => e['address'] as String).toList();

        String userAddress = userAddressList[0]['address'];
        String userAdrType = userAddressList[0]['address_type'];
        String userName = userAddressList[0]['name'];

        Future<void> load() async {
          await storage.write(key: "adr", value: userAddress);
          await storage.write(key: "adrType", value: userAdrType);
          await storage.write(key: "name", value: userName);
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Select an address"),
            backgroundColor: Colors.white,
          ),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (addressTable.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: addressTable.length,
                      itemBuilder: (context, index) {
                        return RadioListTile<int>(
                          title: Text(addressTable[index]),
                          value: index,
                          groupValue: selectedValue,
                          onChanged: (value) async {
                            setState(() {
                              selectedValue = value;
                              authCtrl.storeAdd = addressTable[index];
                            });
                            log("printtttt ${authCtrl.storeAdd}");
                            await load();
                          },
                        );
                      },
                    ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddressPg()));
                      },
                      child: const Text("Click to add Address"),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.deepPurple,
                  height: 60,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: selectedValue != null
                        ? () {
                            // Navigate to the Success page or perform checkout actions
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Payment()));
                          }
                        : null,
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
