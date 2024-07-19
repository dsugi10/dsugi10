import 'package:delivery/provider/prov.dart';
import 'package:delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressPg extends StatefulWidget {
  const AddressPg({Key? key}) : super(key: key);

  @override
  State<AddressPg> createState() => _AddressPgState();
}

class _AddressPgState extends State<AddressPg> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController addTypeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    addTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCtrl = Provider.of<AuthProv>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Address"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Enter your name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: addressController,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                  hintText: "Enter your address",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: addTypeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Address type (Home or work)",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final res = await authCtrl.addAddress(
                      context,
                      addressController.text,
                      addTypeController.text,
                      nameController.text,
                    );
                    if (res == "Address added Successfully") {
                      showToast(context, res);
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
