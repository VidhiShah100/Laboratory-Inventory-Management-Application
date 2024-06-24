import 'package:access_control_flutter/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/fetch_items.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const CustomTextField({
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white), // Set text color to white
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(
              6, 70, 99, 1), // Set background color to blue
          labelText: labelText,
          labelStyle: const TextStyle(
              color: Colors.white), // Set label text color to white
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none, // Remove the border
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 12.0,
          ),
        ),
      ),
    );
  }
}

class UploadItems extends StatefulWidget {
  const UploadItems({Key? key}) : super(key: key);

  @override
  State<UploadItems> createState() => _UploadItemsState();
}

class _UploadItemsState extends State<UploadItems> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _sellableController = TextEditingController();
  final TextEditingController _productLinkController = TextEditingController();
  final TextEditingController _UIDController = TextEditingController();

  void _processInputs() async {
    String? name = _nameController.text;
    String? description = _descriptionController.text;
    String? link = _linkController.text;
    String? price = _priceController.text;
    int? quantity = int.tryParse(_quantityController.text);
    int? time = int.tryParse(_timeController.text);
    String? sellable = _sellableController.text;
    String? productLink = _productLinkController.text;
    String? UID = _UIDController.text;

    // Access the input variables here
    print('Name: $name');
    print('Description: $description');
    print('Link: $link');
    print('Price: $price');
    print('Quantity: $quantity');
    print('Time: $time');
    print('Sellable: $sellable');
    print('Product Link: $productLink');

    final newItem = FirebaseFirestore.instance.collection('items_data').doc();
    final item = ItemsData(
      name: name,
      description: description,
      link: link,
      price: price,
      quantity: quantity,
      time: time,
      sellable: sellable,
      prodLink: productLink,
      UID: "NULL",
      issuedTo: "NULL",
      pastUsers: "NULL",
    );
    final json = item.toJson();
    await newItem.set(json);
    // Navigator.of(context, rootNavigator: true).pushNamed("/home");
    Navigator.push(context, MaterialPageRoute(builder: ((context) => const HomeScreen())));

    // Clear the text fields
    _nameController.clear();
    _descriptionController.clear();
    _linkController.clear();
    _priceController.clear();
    _quantityController.clear();
    _timeController.clear();
    _sellableController.clear();
    _productLinkController.clear();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add an item'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(4, 41, 58, 1),
      ),
      backgroundColor: const Color.fromRGBO(4, 28, 50, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(4, 41, 58, 1),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Column(
              children: [
                const SizedBox(height: 15.0),
                CustomTextField(
                  controller: _nameController,
                  labelText: 'Name',
                ),
                const SizedBox(height: 15.0),
                CustomTextField(
                  controller: _descriptionController,
                  labelText: 'Description',
                ),
                const SizedBox(height: 15.0),
                CustomTextField(
                  controller: _linkController,
                  labelText: 'Link',
                ),
                const SizedBox(height: 15.0),
                CustomTextField(
                  controller: _priceController,
                  labelText: 'Price',
                ),
                const SizedBox(height: 15.0),
                CustomTextField(
                  controller: _quantityController,
                  labelText: 'Quantity',
                ),
                const SizedBox(height: 15.0),
                CustomTextField(
                  controller: _timeController,
                  labelText: 'Time',
                ),
                const SizedBox(height: 15.0),
                CustomTextField(
                  controller: _sellableController,
                  labelText: 'Sellable',
                ),
                const SizedBox(height: 15.0),
                CustomTextField(
                  controller: _productLinkController,
                  labelText: 'Product Link',
                ),
                const SizedBox(height: 16.0),
                Container(
                  width: double.infinity, // Take the length of the container
                  child: ElevatedButton(
                    onPressed: _processInputs,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(236, 179, 101, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
