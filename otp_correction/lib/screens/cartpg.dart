// import 'package:delivery/model/cart_itemCls.dart';
// import 'package:delivery/provider/prov.dart';
// import 'package:delivery/screens/check_Out.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Cart extends StatefulWidget {
//   const Cart({super.key});

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   Map<int, bool> isPressedMap =
//       {}; // Map to store button state for each product
//   Map<int, int> quantityMap = {}; // Map to store quantity for each product

//   @override
//   Widget build(BuildContext context) {
//     final procart = Provider.of<AuthProv>(context);
//     int total = 0;
//     for (CartItem item in procart.items) {
//       total += item.quantity * item.product.price;

//       // Initialize button state and quantity for each product
//       if (!isPressedMap.containsKey(item.product.id)) {
//         isPressedMap[item.product.id] =
//             true; // All cart items start with the button in the pressed state
//         quantityMap[item.product.id] = item.quantity;
//       }
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text("Cart"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: procart.items.length,
//               itemBuilder: (context, index) {
//                 final cartItem = procart.items[index];
//                 int subtotal = cartItem.quantity * cartItem.product.price;
//                 int quantity = quantityMap[cartItem.product.id]!;

//                 return SizedBox(
//                   height: 158,
//                   child: Card(
//                     color: Colors.white,
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 220,
//                           child: Padding(
//                             padding: const EdgeInsets.all(15.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   cartItem.product.name,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 Text(
//                                     '${cartItem.product.description} \n\nRs.${cartItem.product.price}'),
//                                 Text('Sub Total: Rs.$subtotal')
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 150,
//                           width: 110,
//                           child: Stack(
//                             children: [
//                               SizedBox(
//                                 height: 110,
//                                 width: 110,
//                                 child: Image.asset(
//                                   cartItem.product.image,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               Positioned(
//                                 bottom: 14,
//                                 left: 0,
//                                 right: 0,
//                                 child: Container(
//                                   height:
//                                       40, // Adjusted height of the container
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 8),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(
//                                         20), // Adjusted border radius
//                                     color: Colors.white,
//                                     border: Border.all(color: Colors.black),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           procart.increment(cartItem.product);
//                                           setState(() {
//                                             // Update quantity
//                                             quantityMap[cartItem.product.id] =
//                                                 quantityMap[
//                                                         cartItem.product.id]! +
//                                                     1;
//                                           });
//                                         },
//                                         child: const Icon(Icons.add),
//                                       ),
//                                       Text(quantityMap[cartItem.product.id]
//                                           .toString()), // Use quantityMap here
//                                       GestureDetector(
//                                         onTap: () {
//                                           procart.decrement(cartItem.product);
//                                           setState(() {
//                                             // Update quantity
//                                             quantityMap[cartItem.product.id] =
//                                                 procart.items
//                                                     .firstWhere(
//                                                       (item) =>
//                                                           item.product.id ==
//                                                           cartItem.product.id,
//                                                       orElse: () => CartItem(
//                                                           product:
//                                                               cartItem.product,
//                                                           quantity: 0),
//                                                     )
//                                                     .quantity;
//                                             // Check if quantity is zero to toggle button state
//                                             if (quantityMap[
//                                                     cartItem.product.id] ==
//                                                 0) {
//                                               isPressedMap[
//                                                   cartItem.product.id] = false;
//                                             }
//                                           });
//                                         },
//                                         child: const Icon(Icons.remove),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           procart.items.length>0?Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius:
//                     BorderRadius.circular(20), // Adjusted border radius
//                 color: Colors.white,
//                 border: Border.all(color: Colors.black),
//               ),
//               height: 118,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     const Text(
//                       "Payment Info",
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Total",
//                           style: (TextStyle(fontSize: 15)),
//                         ),
//                         Text("Rs.$total",
//                             style: const TextStyle(
//                                 color: Colors.black, fontSize: 15)),
//                       ],
//                     ),
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("GST", style: (TextStyle(fontSize: 15))),
//                         Text("0%",
//                             style: const TextStyle(
//                                 color: Colors.black, fontSize: 15))
//                       ],
//                     ),
//                     SizedBox(height: 14),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text("Grand Total",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16)),
//                         Text("Rs.$total",
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                                 fontSize: 16))
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ):Container(
//             // height: double.infinity,
//             // width: double.infinity,
//             child: Text("Your Cart is empty"),
//           ),

//           Container(
//             height: 60,
//             width: double.infinity,
//             color: Colors.deepPurple,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextButton(

//                   onPressed: () {
//                     procart.items.clear();
//                     Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => CheckOut()));
//                   },
//                   child: Text(
//                     "Check Out",
//                     style: TextStyle(color: Colors.white),
//                   )

//                   ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

//meeeeeee

import 'dart:convert';
import 'dart:developer';

import 'package:delivery/model/cart_itemCls.dart';
import 'package:delivery/provider/prov.dart';
import 'package:delivery/screens/check_Out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Map<int, bool> isPressedMap = {};
  Map<int, int> quantityMap = {};

  @override
  Widget build(BuildContext context) {
    final storage = const FlutterSecureStorage();
    final procart = Provider.of<AuthProv>(context);
    int total = 0;
    for (CartItem item in procart.items) {
      total += item.quantity * item.product.price;

      if (!isPressedMap.containsKey(item.product.id)) {
        isPressedMap[item.product.id] = true;
        quantityMap[item.product.id] = item.quantity;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: procart.items.length > 0
                ? ListView.builder(
                    itemCount: procart.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = procart.items[index];
                      // log("carttttttttt ${cartItem.product.image}");
                      // procart.cartImg.add(cartItem.product.image);
                      // log("message.......${procart.cartImg}");
                      int subtotal = cartItem.quantity * cartItem.product.price;
                      int quantity = quantityMap[cartItem.product.id]!;

                      return SizedBox(
                        height: 180,
                        child: Card(
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 220,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItem.product.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                          '${cartItem.product.description} \n\nRs.${cartItem.product.price}'),
                                      Text('Sub Total: Rs.$subtotal')
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                width: 110,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 110,
                                      width: 110,
                                      child: Image.asset(
                                        cartItem.product.image,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 14,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                procart.increment(
                                                    cartItem.product);
                                                setState(() {
                                                  // Update quantity
                                                  quantityMap[
                                                          cartItem.product.id] =
                                                      quantityMap[cartItem
                                                              .product.id]! +
                                                          1;
                                                });
                                              },
                                              child: const Icon(Icons.add),
                                            ),
                                            Text(quantityMap[
                                                    cartItem.product.id]
                                                .toString()), // Use quantityMap here
                                            GestureDetector(
                                              onTap: () {
                                                procart.decrement(
                                                    cartItem.product);
                                                if (quantity == 1)
                                                  procart.cartImg.remove(
                                                      cartItem.product.image);
                                                log("Cart unique images: ${procart.cartImg}");

                                                setState(() {
                                                  // Update quantity
                                                  quantityMap[
                                                      cartItem.product
                                                          .id] = procart.items
                                                      .firstWhere(
                                                        (item) =>
                                                            item.product.id ==
                                                            cartItem.product.id,
                                                        orElse: () => CartItem(
                                                            product: cartItem
                                                                .product,
                                                            quantity: 0),
                                                      )
                                                      .quantity;
                                                  // Check if quantity is zero to toggle button state
                                                  if (quantityMap[cartItem
                                                          .product.id] ==
                                                      0) {
                                                    isPressedMap[cartItem
                                                        .product.id] = false;
                                                  }
                                                });
                                              },
                                              child: const Icon(Icons.remove),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Your Cart is empty"),
                  ),
          ),
          if (procart.items.length > 0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                height: 118,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        "Payment Info",
                        style: TextStyle(fontSize: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text("Rs.$total",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15)),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("GST", style: TextStyle(fontSize: 15)),
                          Text("0%",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15))
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Grand Total",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text("Rs.$total",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          procart.items.length > 0
              ? Container(
                  height: 60,
                  width: double.infinity,
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {


                        String jsonString = jsonEncode(procart
                            .cartImg.toList()); // Convert the list to a JSON string
                        await storage.write(key: "Img", value: jsonString);


                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CheckOut()));
                      },
                      child: const Text(
                        "Proceed to Pay",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
//meee


//-----------------------------------------------------------------------------------------------------------------------------------------------------------------



// import 'dart:developer';

// import 'package:delivery/model/cart_itemCls.dart';
// import 'package:delivery/provider/prov.dart';
// import 'package:delivery/screens/check_Out.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class Cart extends StatefulWidget {
//   const Cart({super.key});

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   Map<int, bool> isPressedMap = {};
//   Map<int, int> quantityMap = {};



//   @override
//   Widget build(BuildContext context) {
//     final procart = Provider.of<AuthProv>(context);
//     int total = 0;
//     for (CartItem item in procart.items) {
//       total += item.quantity * item.product.price;

//       if (!isPressedMap.containsKey(item.product.id)) {
//         isPressedMap[item.product.id] = true;
//         quantityMap[item.product.id] = item.quantity;
//       }
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text("Cart"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: procart.items.length > 0
//                 ? ListView.builder(
//                     itemCount: procart.items.length,
//                     itemBuilder: (context, index) {
//                       final cartItem = procart.items[index];
//                       int subtotal = cartItem.quantity * cartItem.product.price;
//                       int quantity = quantityMap[cartItem.product.id]!;

//                       return SizedBox(
//                         height: 180,
//                         child: Card(
//                           color: Colors.white,
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 220,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         cartItem.product.name,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                       Text(
//                                           '${cartItem.product.description} \n\nRs.${cartItem.product.price}'),
//                                       Text('Sub Total: Rs.$subtotal')
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 150,
//                                 width: 110,
//                                 child: Stack(
//                                   children: [
//                                     SizedBox(
//                                       height: 110,
//                                       width: 110,
//                                       child: Image.asset(
//                                         cartItem.product.image,
//                                         fit: BoxFit.fill,
//                                       ),
//                                     ),
//                                     Positioned(
//                                       bottom: 14,
//                                       left: 0,
//                                       right: 0,
//                                       child: Container(
//                                         height: 40,
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(20),
//                                           color: Colors.white,
//                                           border: Border.all(color: Colors.black),
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             GestureDetector(
//                                               onTap: () {
//                                                 procart.increment(cartItem.product);
//                                                 setState(() {
//                                                   quantityMap[cartItem.product.id] =
//                                                       quantityMap[cartItem.product.id]! +
//                                                           1;
//                                                 });
//                                               },
//                                               child: const Icon(Icons.add),
//                                             ),
//                                             Text(quantityMap[cartItem.product.id]
//                                                 .toString()),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 procart.decrement(cartItem.product);
//                                                 if (quantity == 1)
//                                                   procart.cartImg
//                                                       .remove(cartItem.product.image);
//                                                 log("Cart unique images: ${procart.cartImg}");

//                                                 setState(() {
//                                                   quantityMap[cartItem.product.id] =
//                                                       procart.items
//                                                           .firstWhere(
//                                                             (item) =>
//                                                                 item.product.id ==
//                                                                 cartItem.product.id,
//                                                             orElse: () => CartItem(
//                                                                 product: cartItem.product,
//                                                                 quantity: 0),
//                                                           )
//                                                           .quantity;

//                                                   if (quantityMap[cartItem.product.id] ==
//                                                       0) {
//                                                     isPressedMap[
//                                                         cartItem.product.id] = false;
//                                                   }
//                                                 });
//                                               },
//                                               child: const Icon(Icons.remove),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   )
//                 : const Center(
//                     child: Text("Your Cart is empty"),
//                   ),
//           ),
//           if (procart.items.length > 0)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.white,
//                   border: Border.all(color: Colors.black),
//                 ),
//                 height: 118,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       const Text(
//                         "Payment Info",
//                         style: TextStyle(fontSize: 15),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Total",
//                             style: TextStyle(fontSize: 15),
//                           ),
//                           Text("Rs.$total",
//                               style: const TextStyle(color: Colors.black, fontSize: 15)),
//                         ],
//                       ),
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("GST", style: TextStyle(fontSize: 15)),
//                           Text("0%",
//                               style: TextStyle(color: Colors.black, fontSize: 15))
//                         ],
//                       ),
//                       const SizedBox(height: 14),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text("Grand Total",
//                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                           Text("Rs.$total",
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16))
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           procart.items.length > 0
//               ? Container(
//                   height: 60,
//                   width: double.infinity,
//                   color: Colors.deepPurple,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const CheckOut()));
//                       },
//                       child: const Text(
//                         "Proceed to Pay",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 )
//               : Container()
//         ],
//       ),
//     );
//   }
// }
