import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:access_control_flutter/models/fetch_items.dart';

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TrackItems(),
    );
  }
}

// class Item {
//   final String name;
//   final String imagePath;
//   final int quantity;
//   final String status;
//
//   Item(
//       {required this.name,
//       required this.imagePath,
//       required this.quantity,
//       required this.status});
// }

class TrackItems extends StatelessWidget {

  Stream<List<ItemsData>> getItems() {
  return FirebaseFirestore.instance
      .collection("items_data")
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => ItemsData.fromJson(doc.data()))
      .toList());}
  // final List<ItemsData> items = [
  //   Item(
  //       name: 'Item 1',
  //       imagePath: 'assets/item1.jpg',
  //       quantity: 3,
  //       status: 'due \'x\' days'),
  //   Item(
  //     name: 'Item 2',
  //     imagePath: 'assets/item1.jpg',
  //     quantity: 4,
  //     status: 'Pending',
  //   ),
  //   Item(
  //     name: 'Item 3',
  //     imagePath: 'assets/item1.jpg',
  //     quantity: 1,
  //     status: 'Approved',
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Color(0xFF041C32),
      appBar: AppBar(
        title: Text(
          'Track Items',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {},
        ),
        backgroundColor: Color(0xFF04293A),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF064663),
          borderRadius: const BorderRadius.only(
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
      body: Center(
        child: StreamBuilder<List<ItemsData>>(
          stream: getItems(),
          builder: (context,snapshot) {
            final items=snapshot.data!;
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  ItemsData item = items[index];
                  String s=item.UID??" ";
                  print(item.UID);
                  if(item.UID!="null"){
                  return Padding(
                    padding: EdgeInsets.all(0.02 * screenWidth),
                    child: Card(
                      color: Color(0xFF064663),
                      child: Padding(
                        padding: EdgeInsets.all(0.02 * screenWidth),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(17),
                                  child: Image(
                                    image: AssetImage("assets/item1.jpg"),
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.bottomCenter,
                                  ),
                                ),
                                Column(children: [
                                  Text(
                                    item.name ??" ",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                  Text(
                                    '      Quantity: ' +
                                        item.quantity.toString(), //
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                                // SizedBox(width: screenWidth * 0.06),
                                Spacer(),
                                IconButton(
                                    onPressed: () async{
                                      var list = ['User123'];
                                      await FirebaseFirestore.instance.collection('users').doc('lobar3JnyMeqNvupGbpYCV6R0QP2').update({"Issued Items": FieldValue.arrayUnion(list)});

                                    },
                                    icon: Icon(Icons.check_rounded),color: Colors.green,),
                                IconButton(
                                    onPressed: () async{
                                      int a=item.quantity??0;
                                      await FirebaseFirestore.instance.collection('item_data').doc(item.UID).update(
                                      {
                                        'Item Quantity' : a+1,
                                      'UID': 'NULL'
                                      });
                                    },
                                    icon:
                                    Icon(Icons.close_rounded),color:Colors.red),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );}
                });
          }
        ),
      ),
    );
  }
}
