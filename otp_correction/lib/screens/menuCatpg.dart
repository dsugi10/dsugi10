

import 'dart:developer';

import 'package:delivery/model/cart_itemCls.dart';
import 'package:delivery/model/menucatCls.dart';
import 'package:delivery/model/menuitemcls.dart';

import 'package:delivery/provider/prov.dart';
import 'package:delivery/screens/cartpg.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuCat extends StatefulWidget {
  final String restaurantName;
  final List<MenuCategory> menulist;

  const MenuCat({
    Key? key,
    required this.restaurantName,
    required this.menulist,
  }) : super(key: key);

  @override
  State<MenuCat> createState() => _MenuCatState();
}

class _MenuCatState extends State<MenuCat> {
  Map<int, bool> isPressedMap =
      {}; // Map to store button state for each product
  Map<int, int> quantityMap = {}; // Map to store quantity for each product

  @override
  Widget build(BuildContext context) {
    final procart = Provider.of<AuthProv>(context);

    // Flatten the list of categories to get a single list of items
    final allItems =
        widget.menulist.expand((category) => category.items).toList();

    // Initialize button state and quantity for each product from the cart
    for (var item in procart.items) {
      isPressedMap[item.product.id] = true;
      quantityMap[item.product.id] = item.quantity;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.restaurantName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Cart()));
              },
              icon: Badge(
                backgroundColor: Colors.red,
                label: Text("${procart.items.length}"),
                smallSize: 12.0,
                child: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: allItems.length,
        itemBuilder: (context, index) {
          MenuItem items = allItems[index];

          // Initialize button state and quantity for each product
          if (!isPressedMap.containsKey(items.id)) {
            isPressedMap[items.id] = false;
            quantityMap[items.id] = 0;
          }

          int quantity = quantityMap[items.id] ?? 0;

          return SizedBox(
            height: 158,
            child: Card(
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    width: 220,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          Text("${items.description} \n\nRs.${items.price}"),
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
                            items.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 14,
                          left: 0,
                          right: 0,
                          child: isPressedMap[items.id]! && quantity != 0
                              ? Container(
                                  height: 40,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          procart.increment(items);
                                          setState(() {
                                            quantityMap[items.id] =
                                                quantityMap[items.id]! + 1;
                                          });
                                        },
                                        child: const Icon(Icons.add),
                                      ),
                                      Text(quantity.toString()),
                                      GestureDetector(
                                        onTap: () {
                                          procart.decrement(items);
                                          procart.cartImg.remove(items.image);
                                          log("Unique images ddds: ${procart.cartImg}");
                                          setState(() {
                                            quantity = procart.items
                                                .firstWhere(
                                                  (item) =>
                                                      item.product.id ==
                                                      items.id,
                                                  orElse: () => CartItem(
                                                      product: items,
                                                      quantity: 0),
                                                )
                                                .quantity;
                                            quantityMap[items.id] = quantity;
                                            if (quantity == 0) {
                                              isPressedMap[items.id] = false;
                                            }
                                          });
                                        },
                                        child: const Icon(Icons.remove),
                                      ),
                                    ],
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    procart.increment(items);
                                    procart.cartImg.add(items.image);
                                    procart.cartImg =
                                        procart.cartImg.toSet().toList();
                                    log("Unique images: ${procart.cartImg}");
                                    setState(() {
                                      isPressedMap[items.id] = true;
                                      quantityMap[items.id] = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: const Center(child: Text("ADD")),
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
      ),
    );
  }
}
