import 'package:flutter/material.dart';
import 'package:access_control_flutter/models/fetch_items.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TrackItems(),
    );
  }
}

class Item {
  final String name;
  final String imagePath;
  final int quantity;
  final String status;

  Item(
      {required this.name,
      required this.imagePath,
      required this.quantity,
      required this.status});
}

class TrackItems extends StatefulWidget {
  const TrackItems({super.key});

  @override
  State<TrackItems> createState() => _TrackItemsState();
}

class _TrackItemsState extends State<TrackItems> {
  final List<String> categories = ['Due', 'Pending'];
  List<String> selectedCategories = [];
  final List<Item> itemsList = [
    Item(
        name: 'WhatIsYourNAme?qwertyuiopasdfgh',
        imagePath: 'assets/item1.jpg',
        quantity: 3,
        status: 'Due'),
    Item(
      name: 'Item 2',
      imagePath: 'assets/item1.jpg',
      quantity: 4,
      status: 'Pending',
    ),
    Item(
      name: 'Item 3',
      imagePath: 'assets/item1.jpg',
      quantity: 1,
      status: 'Due',
    ),
    Item(
      name: 'Item 4',
      imagePath: 'assets/stock_img_brown.jpeg',
      quantity: 1,
      status: 'Pending',
    ),
    Item(
      name: 'Item 4',
      imagePath: 'assets/stock_img_brown.jpeg',
      quantity: 1,
      status: 'Pending',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    final filterItems = itemsList.where((item) {
      return selectedCategories.isEmpty ||
          selectedCategories.contains(item.status);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF041C32),
      appBar: AppBar(
        title: const Text(
          'Track Items',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {},
        ),
        backgroundColor: const Color(0xFF04293A),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFF064663),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          IconButton(
              enableFeedback: true,
              iconSize: 30.0,
              onPressed: () {},
              icon: const Icon(Icons.home_rounded),
              color: Colors.white),
          IconButton(
              enableFeedback: true,
              onPressed: () {},
              iconSize: 30.0,
              icon: const Icon(Icons.add_circle_outline_rounded),
              color: Colors.white),
          IconButton(
              enableFeedback: true,
              onPressed: () {},
              iconSize: 30.0,
              icon: const Icon(Icons.person),
              color: Colors.white),
        ]),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  left: 0.02 * screenWidth, top: 0.01 * screenHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: categories
                    .map((category) => FilterChip(
                        label: Text(category),
                        selected: selectedCategories.contains(category),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedCategories.add(category);
                            } else {
                              selectedCategories.remove(category);
                            }
                          });
                        }))
                    .toList(),
              )),
          Expanded(
              child: ListView.builder(
                  itemCount: filterItems.length,
                  itemBuilder: (context, index) {
                    final item = filterItems[index];
                    return Card(
                      color: const Color(0xFF064663),
                      child: Padding(
                        padding: EdgeInsets.all(0.02 * screenWidth),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(17),
                                child: Image(
                                  image: AssetImage(item.imagePath),
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                              SizedBox(width: 0.03 * screenWidth),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      'Quantity: ${item.quantity}',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Card(
                                      color: const Color(0xFFECB365),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(0.01 * screenWidth),
                                        child: Text(
                                          'Status: ${item.status}',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ]),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
