import 'package:delivery/provider/prov.dart';
import 'package:delivery/screens/success.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int? selectedRadio;

  @override
  Widget build(BuildContext context) {
    final procart = Provider.of<AuthProv>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Payment Methods"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                RadioListTile<int>(
                  title: const Text("COD"),
                  value: 1,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: const Text("G Pay"),
                  value: 2,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: const Text("PayTM"),
                  value: 3,
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() {
                      selectedRadio = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.deepPurple,
              height: 60,
              width: double.infinity,
              child: TextButton(
                onPressed: selectedRadio != null
                    ? () {
                        procart.clearItems();
                
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Success()));
                      }
                    : null,
                child: const Text(
                  "Check Out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
