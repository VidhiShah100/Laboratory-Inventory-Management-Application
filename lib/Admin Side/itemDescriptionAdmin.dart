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

  final List<CurrentUser> _currentUsers = [
    CurrentUser(username: 'User 1', daysLeft: 4),
    CurrentUser(username: 'User 2', daysLeft: 5),
    CurrentUser(username: 'User 3', daysLeft: 3),
    // Add more current user options as needed
  ];

  Stock stock = Stock(inStock: true, quantity: 10);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    return Scaffold(
        backgroundColor: const Color(0xff041C32),
        appBar: AppBar(
          title: const Text('Item Description Admin'),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
          backgroundColor: const Color(0xFF064663),
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
                  SizedBox(width: 0.28 * screenWidth),
                  Center(child: Image.asset('assets/stock_img_black.jpg')),
                  SizedBox(width: 0.28 * screenWidth),
                  Center(child: Image.asset('assets/stock_img_blue.jpeg')),
                  SizedBox(width: 0.28 * screenWidth),
                  Center(child: Image.asset('assets/stock_img_brown.jpeg')),
                  SizedBox(width: 0.28 * screenWidth),
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
                      color: Colors.white,
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
                  top: screenHeight * 0.01, left: screenWidth * 0.04),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam porta elit a porttitor blandit. Vestibulum congue lacus a lectus sagittis bibendum. '
                'Duis finibus, nunc a fringilla mattis, tortor diam rutrum erat, eget vulputate ante mi vel leo. Maecenas molestie leo et magna sagittis, sed cursus nisl posuere. ${screenHeight.toStringAsFixed(2)}, ${screenWidth.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
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
                  color: Colors.white,
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
                  color: Colors.white,
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
                    color: Color(0xFF064663),
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
                  bottom: 0,
                  child: SizedBox(
                    height: 0.16 * screenHeight,
                    width: screenWidth,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          backgroundColor: const Color(0xFF04293A),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Currently Issued To',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      backgroundColor: const Color(0xFF064663),
                                      content: SingleChildScrollView(
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          height: 0.4 * screenHeight,
                                          child: ListView.builder(
                                              itemCount: _currentUsers.length,
                                              itemBuilder: (context, index) {
                                                final currentUser =
                                                    _currentUsers[index];
                                                return ListTile(
                                                    title: Text(
                                                      currentUser.username,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Text(
                                                      'Due in (days):  ${(currentUser.daysLeft)}',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ));
                                              }),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFECB365)),
                                          child: const Text(
                                            'Close',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                          );
                        },
                        child: const Text(
                          'Current Users',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: screenWidth,
                    height: 0.08 * screenHeight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          backgroundColor: const Color(0xFFECB365),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Checkout History',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      backgroundColor: const Color(0xFF064663),
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
                                                    title: Text(
                                                      userReturn.username,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Text(
                                                      'Return Date: ${DateFormat('dd-MM-yyyy').format(userReturn.returnDate)}',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ));
                                              }),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFECB365)),
                                          child: const Text(
                                            'Close',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
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
