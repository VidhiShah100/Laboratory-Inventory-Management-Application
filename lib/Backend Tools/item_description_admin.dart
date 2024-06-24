import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserReturn {
  String username;
  DateTime returnDate;
  UserReturn({required this.username, required this.returnDate});
}

class CurrentUser {
  String username;
  int daysLeft;
  CurrentUser({required this.username, required this.daysLeft});
}

class Stock {
  bool inStock = false; // Default value for in stock
  int quantity = 1;
  Stock({required this.inStock, required this.quantity});
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<UserReturn> _pastUsers = [
    UserReturn(username: 'User 1', returnDate: DateTime(2023, 6, 21)),
    UserReturn(username: 'User 2', returnDate: DateTime(2023, 6, 19)),
    UserReturn(username: 'User 3', returnDate: DateTime(2023, 6, 15)),
    UserReturn(username: 'User 4', returnDate: DateTime(2023, 5, 24)),
    UserReturn(username: 'User 5', returnDate: DateTime(2023, 4, 21)),
    UserReturn(username: 'User 6', returnDate: DateTime(2023, 4, 4)),
    // Add more past user options as needed
  ];

  Stock stock = Stock(inStock: true, quantity: 10);
  CurrentUser currentUser = CurrentUser(username: 'Abcd', daysLeft: 5);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Item Description Admin'),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))]
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(height: 0.03 * screenHeight),
            SizedBox(
              height: 0.27 * screenHeight,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 0.20 * screenWidth),
                  Center(child: Image.asset('assets/stock_img_black.jpg')),
                  SizedBox(width: 0.28 * screenWidth),
                  Center(child: Image.asset('assets/stock_img_black.jpg')),
                  SizedBox(width: 0.28 * screenWidth),
                  Center(child: Image.asset('assets/stock_img_black.jpg')),
                  SizedBox(width: 0.20 * screenWidth),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.01, left: screenWidth * 0.04),
                  child: const Text(
                    'Item Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.015, left: screenWidth * 0.25),
                  child: Text(
                    'Category - ${stock.inStock ? 'Available' : 'Not Available'}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: stock.inStock ? Colors.green : Colors.red,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.01, left: screenWidth * 0.04,),
              child: const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam porta elit a porttitor blandit. Vestibulum congue lacus a lectus sagittis bibendum. '
                'Duis finibus, nunc a fringilla mattis, tortor diam rutrum erat, eget vulputate ante mi vel leo. Maecenas molestie leo et magna sagittis, sed cursus nisl posuere. ',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 0.02 * screenHeight, right: 0.7 * screenWidth),
              child: const Text(
                'Item Price',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 0.001 * screenHeight,
                  right: 0.8 * screenWidth,
                  bottom: 0.047 * screenHeight),
              child: const Text(
                '\$99.99',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            
              Align(
                alignment: Alignment.bottomCenter,
                child: Stack(children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.0),
                      ),
                      color: Color(0xFF04293A),
                    ),
                    height: 0.24 * screenHeight,
                    width: screenWidth,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 0.02 * screenHeight,
                      ),
                      child: Text(
                        'Quantity: ${stock.quantity}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.07 * screenHeight,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.0),
                        ),
                        color: Color.fromARGB(255, 66, 20, 104),
                      ),
                      height: 0.18 * screenHeight,
                      width: screenWidth,
                      child: Positioned(
                        top: 0.5 * screenHeight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 0.02 * screenHeight,
                            bottom:0.00
                          ),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Current User - ${currentUser.username}',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 0.01 * screenHeight,
                                  ),
                                  child: Text(
                                    '  (${currentUser.daysLeft} days left)',
                                    style: const TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.15 * screenHeight,
                    child: SizedBox(
                      width: screenWidth,
                      height: 0.09 * screenHeight,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Checkout History'),
                                        content: SingleChildScrollView(
                                          child: SizedBox(
                                            width: double.maxFinite,
                                            height: 0.4 * screenHeight,
                                            child: ListView.builder(
                                                itemCount: _pastUsers.length,
                                                itemBuilder: (context, index) {
                                                  final userReturn =
                                                      _pastUsers[index];
                                                  return ListTile(
                                                      title:
                                                          Text(userReturn.username),
                                                      subtitle: Text(
                                                          'Return Date: ${DateFormat('dd-MM-yyyy').format(userReturn.returnDate)}'));
                                                }),
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Close'),
                                          )
                                        ],
                                      );
                                    });
                              },
                            );
                          },
                          child: const Text(
                            'Past Users',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  )
                ]),
              ),
            
          ]),
        ));
  }
}

void main() {
  runApp(const MaterialApp(
    home: AdminPage(),
  ));
}
