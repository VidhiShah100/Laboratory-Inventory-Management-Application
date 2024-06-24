import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RequestedItemsScreen(),
    );
  }
}

class Item {
  final String name;
  final String imagePath;
  final int quantity;
  final bool isApproved;

  Item({required this.name, required this.imagePath, required this.quantity, required this.isApproved});
}

class RequestedItemsScreen extends StatelessWidget {
  final List<Item> items = [
    Item(
      name: 'Item 1',
      imagePath: 'assets/stock_img_brown.jpeg',
      quantity: 3,
      isApproved: true,
    ),
    Item(
      name: 'Item 2',
      imagePath: 'assets/stock_img_brown.jpeg',
      quantity: 4,
      isApproved: false,
    ),
    Item(
      name: 'Item 3',
      imagePath: 'assets/stock_img_brown.jpeg',
      quantity: 1,
      isApproved: true,
    ),
  ];

 RequestedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF041C32),

      appBar: AppBar(
        title: const Text('Requested Items', style: TextStyle(fontSize:24, fontWeight: FontWeight.bold, color: Colors.white ),),
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
          child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              IconButton(
              enableFeedback: true,
              iconSize: 30.0,
              onPressed: () {},
              icon: const Icon( Icons.home_rounded), color: Colors.white),
        IconButton(
          enableFeedback: true,
          onPressed: () {},
            iconSize: 30.0,
          icon: const Icon( Icons.shopping_cart_rounded), color: Colors.white),
        IconButton(
            enableFeedback: true,
            onPressed: () {},
            iconSize: 30.0,
            icon: const Icon( Icons.menu_rounded), color: Colors.white),
        IconButton(
            enableFeedback: true,
            onPressed: () {},
            iconSize: 30.0,
            icon: const Icon( Icons.person), color: Colors.white),
        ]
      ),
    ), body: Center(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              Item item = items[index];
              return Padding(
                padding: const EdgeInsets.all(13.0),
                child: Card(
                  color: const Color(0xFF064663),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children :[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                            child: Image(
                              image: AssetImage(item.imagePath),
                              width: 120.0,
                              height: 120.0,
                              fit: BoxFit.cover,
                              alignment: Alignment.bottomCenter,
                            ),
                            ),
                            Column(
                              children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.end,
                            ),
                                Text(
                                  '     Quantity: ${item.quantity}', //
                                  style: const TextStyle(
                                    fontSize: 16.0,color: Colors.white,fontWeight: FontWeight.bold,
                                  ),
                                ), ]
                            ),
                                const SizedBox(width: 30.0),
                             Row(
                               children: [
                                  const Text(
                              'Status: ',
                              
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                           item.isApproved? const Text('Approved',style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            )) : const Text('Pending',style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),),
                                    ],),
                    ],),
              ],),
                ),),
              );
            }
        ),
      ),
    );
  }
}

