
import 'dart:convert';
import 'dart:developer';

import 'package:delivery/model/cart_itemCls.dart';
import 'package:delivery/model/menuitemcls.dart';
import 'package:delivery/query_mut/mutations.dart';
import 'package:delivery/query_mut/query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';



class AuthProv extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  static GraphQLClient? client;
  dynamic userFetch;
  var storeAdd;
  List cartImg=[];
  String? getAdrType;
  String? getAdr;
  String? getUserName;



//me
  Future checkNum(BuildContext context, mobnum) async {
    log("mobile num: $mobnum");
    final client = GraphQLProvider.of(context).value;

    final QueryResult result = await client.query(
        QueryOptions(document: gql(getNum), variables: {"phone_num": mobnum}));
    log("Result:${result.data}");
    if (result.hasException) {
      print("graphqlEr: ${result.exception!.graphqlErrors}");
      print("LinkExc: ${result.exception!.linkException}");
    }

    final num = (result.data != null &&
            result.data!['user_table'] != null &&
            result.data!['user_table'].isNotEmpty)
        ? result.data!['user_table'][0]['phone_num']
        : null;

    log("phone number: $num");

    if (num != null && num.isNotEmpty) {
      return "This mobile number is already registered";
    }
  }


//meee
  Future newUser(BuildContext context, username, mobnum) async {
    final client = GraphQLProvider.of(context).value;

    final QueryResult result = await client.mutate(MutationOptions(
        document: gql(insertUser),
        variables: {"username": username, "phone_num": mobnum}));
    log("result: ${result.data!['insert_user_table']['returning'][0]['id']}");
    var editID = result.data!['insert_user_table']['returning'][0]['id'];
    log("EdittIDDD: ${editID}");
    await storage.write(key: "UpID", value: editID);

    var uuuname = result.data!['insert_user_table']['returning'][0]['username'];
    await storage.write(key: "username", value: uuuname);

    var phhnnn = result.data!['insert_user_table']['returning'][0]['phone_num'];

    await storage.write(key: "mob", value: phhnnn);

    if (result.hasException) {
      log("graphQLError: ${result.exception!.graphqlErrors}");
      log("LinkExc: ${result.exception!.linkException}");
    }

    if (result.data != null) {
      return "Inserted Successfully";
    } else {
      return "Exception Error";
    }
  }







  Future userEdit(id, mobileNum, username, BuildContext context) async {
    log("id: $id");

    log("name:$username");
    log("contact : $mobileNum");

    client = GraphQLProvider.of(context).value;

    final QueryResult result = await client!.mutate(MutationOptions(
      document: gql(editUser),
      variables: {'id': id, 'phone_num': mobileNum, 'username': username},
    ));
    log("REsssssssss ${result.data}");

    await storage.write(
        key: 'username',
        value: result.data!['update_user_table']['returning'][0]['username']);

    await storage.write(
        key: 'mobile',
        value: result.data!['update_user_table']['returning'][0]['phone_num']);

    if (result.hasException) {
      log("ressssssss ${result.exception!.graphqlErrors}");
      log("ressssssss ${result.exception!.linkException}");
    }
    if (result.data != null) {
      //  userFetch();
      return 'Updated Successfully';
    } else {
      return 'Exception Error';
    }
  }

  Future logCred(BuildContext context, mobNum) async {
    final client = GraphQLProvider.of(context).value;

    final QueryResult result = await client.query(
        QueryOptions(document: gql(login), variables: {"phone_num": mobNum}));

    log("Result:${result.data}");

    if (result.hasException) {
      print("graphqlEr: ${result.exception!.graphqlErrors}");
      print("LinkExc: ${result.exception!.linkException}");
    }

    if (result.data != null &&
        result.data!['user_table'] != null &&
        result.data!['user_table'].isNotEmpty) {
      log("result: ${result.data!['user_table'][0]['id']}");
      var LOGID = result.data!['user_table'][0]['id'];
      log("LogIDDD: ${LOGID}");
      await storage.write(key: "UpID", value: LOGID);

      var phone_num = result.data!['user_table'][0]['phone_num'];
      log("mobilenum :$phone_num");
      await storage.write(key: "mob", value: phone_num);

      // var passw = result.data!['user_table'][0]['password'];
      // log("pswd :$passw");
      // await storage.write(key: "password", value: passw);

      // var mail = result.data!['user_table'][0]['mail_id'];
      // log("maill :$mail");
      // await storage.write(key: "email", value: mail);

      return "Login Successful";
    } else {
      return "User does not exist. Try Registering.";
    }
  }

  // Future checkReg(BuildContext context, mobnum) async {
  //   log("mobile num: $mobnum");
  //   final client = GraphQLProvider.of(context).value;

  //   final QueryResult result = await client.query(
  //       QueryOptions(document: gql(getNum), variables: {"phone_num": mobnum}));
  //   log("Result:${result.data}");
  //   if (result.hasException) {
  //     print("graphqlEr: ${result.exception!.graphqlErrors}");
  //     print("LinkExc: ${result.exception!.linkException}");
  //   }

  //   final userTable = result.data != null ? result.data!['user_table'] : null;
  //   if (userTable == null || userTable.isEmpty) {
  //     return "This mobile number does not exist. Try Registering";
  //   }

  //   // final num = (result.data != null &&
  //   //         result.data!['user_table'] != null &&
  //   //         result.data!['user_table'].isNotEmpty)
  //   //     ? result.data!['user_table'][0]['phone_num']
  //   //     : null;

  //   final user = userTable[0];
  //   final num = user['phone_num'];

  //   log("phone number: $num");

  //   var ID = result.data!['user_table'][0]['id'];
  //   log("M_IDDD: ${ID}");
  //   await storage.write(key: "UpID", value: ID);

  //   var phone_num = result.data!['user_table'][0]['phone_num'];
  //   log("M_mobilenum :$phone_num");
  //   await storage.write(key: "mob", value: phone_num);

  //   // var passw = result.data!['user_table'][0]['password'];
  //   // log("M_pswd :$passw");
  //   // await storage.write(key: "password", value: passw);

  //   // var mail = result.data!['user_table'][0]['mail_id'];
  //   // log("M_maill :$mail");
  //   // await storage.write(key: "email", value: mail);

  //   var username = result.data!['user_table'][0]['username'];
  //   log("M_uname :$username");
  //   await storage.write(key: "username", value: username);
  //   if (num != null && num.isNotEmpty) {
  //     return "Success";
  //   } else {
  //     return "This mobile number does not exist. Try Registering";
  //   }
  // }




  Future<String> checkReg(BuildContext context, String mobnum) async {
  log("mobile num: $mobnum");
  final client = GraphQLProvider.of(context).value;

  final QueryResult result = await client.query(
    QueryOptions(
      document: gql(getNum),
      variables: {"phone_num": mobnum},
    ),
  );

  log("Result: ${result.data}");

  if (result.hasException) {
    print("graphqlEr: ${result.exception!.graphqlErrors}");
    print("LinkExc: ${result.exception!.linkException}");
    return "An error occurred while checking the number";
  }

  final userTable = result.data != null ? result.data!['user_table'] : null;
  if (userTable == null || userTable.isEmpty) {
    return "This mobile number does not exist. Try Registering";
  }

  final user = userTable[0];
  final num = user['phone_num'];

  log("phone number: $num");

  var ID = user['id'];
  log("M_IDDD: $ID");
  await storage.write(key: "UpID", value: ID);

  var phone_num = user['phone_num'];
  log("M_mobilenum :$phone_num");
  await storage.write(key: "mob", value: phone_num);

  // Uncomment if needed
  // var passw = user['password'];
  // log("M_pswd :$passw");
  // await storage.write(key: "password", value: passw);

  // var mail = user['mail_id'];
  // log("M_maill :$mail");
  // await storage.write(key: "email", value: mail);

  var username = user['username'];
  log("M_uname :$username");
  await storage.write(key: "username", value: username);

  if (num != null && num.isNotEmpty) {
    return "Success";
  } else {
    return "This mobile number does not exist. Try Registering";
  }
}









List<CartItem> _items = [];
  List<CartItem> get items => [..._items];

  AuthProv() {
    loadCart();
  }

  void increment(MenuItem product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        item.quantity++;
        saveCart();
        notifyListeners();
        return;
      }
    }
    _items.add(CartItem(product: product, quantity: 1));
    cartImg.add(product.image);
    cartImg = cartImg.toSet().toList(); // Remove duplicates
    saveCart();
    notifyListeners();
  }

  void decrement(MenuItem product) {
    for (var item in _items) {
      if (item.product.id == product.id) {
        item.quantity--;
        if (item.quantity < 1) {
          _items.removeWhere((i) => i.product.id == product.id);
          cartImg.remove(product.image);
        }
        saveCart();
        notifyListeners();
        return;
      }
    }
  }

  void clearItems() {
    _items.clear();
    cartImg.clear();
    saveCart();
    notifyListeners();
  }

  Future<void> saveCart() async {
    List<Map<String, dynamic>> cartItems = _items.map((item) => {
      'product': item.product.toMap(),
      'quantity': item.quantity,
    }).toList();

    String jsonString = jsonEncode({
      'items': cartItems,
      'cartImg': cartImg,
    });

    await storage.write(key: 'cart', value: jsonString);
  }

  Future<void> loadCart() async {
    String? jsonString = await storage.read(key: 'cart');
    if (jsonString != null) {
      Map<String, dynamic> data = jsonDecode(jsonString);
      List<dynamic> cartItems = data['items'];
      cartImg = List<String>.from(data['cartImg']);

      _items = cartItems.map((item) {
        MenuItem product = MenuItem.fromMap(item['product']);
        return CartItem(product: product, quantity: item['quantity']);
      }).toList();
      notifyListeners();
    }
  }
  











  Future addAddress(BuildContext context, address, adrsType, name) async {
    final client = GraphQLProvider.of(context).value;
    var a_uid=await storage.read(key: "UpID");
    log("A_userId: $a_uid");

    final QueryResult result = await client.mutate(MutationOptions(
        document: gql(insertAddress),
        variables: {
          "address": address,
          "address_type": adrsType,
          "name": name,
          "user_id":a_uid
          
        }));
        
        log("address: $address");
        log("adrType: $adrsType");
        log("namee: $name");

    if (result.hasException) {
      log("graphQLError: ${result.exception!.graphqlErrors}");
      log("LinkExc: ${result.exception!.linkException}");
    }

    if (result.data != null) {
   userFetch();
      return "Address added Successfully";
    } else {
      return "Exception Error";
    }
  }
  
}


