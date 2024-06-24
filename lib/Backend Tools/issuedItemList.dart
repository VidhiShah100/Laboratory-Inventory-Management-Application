import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class IssuedList extends StatelessWidget {
  final List issuedlist;
  const IssuedList({super.key, required this.issuedlist});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    // double screenHeight = mediaQueryData.size.height;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    if (issuedlist.isEmpty) {
      return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17.0),
            ),
            color: Colors.black,
            child: Container(
              color: Colors.black,
              child: Text(
                'No Item Issued',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ));
    } else {
      return ListView.builder(
        itemCount: issuedlist.length > 3 ? 3 : issuedlist.length,
        itemBuilder: (context, index) {
          final itemId = issuedlist[index];
          return StreamBuilder(
              stream:
                  _firestore.collection('items_data').doc(itemId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No data found"),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  final Map<String, dynamic>? userData =
                      (snapshot.data?.data() as Map<String, dynamic>);
                  final String itemname = userData?['Item name'] ?? '';
                  final displayItemName = itemname.length > 25
                      ? itemname.substring(0, 25) + '...'
                      : itemname;
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                      color: const Color(0xff04293A),
                      child: Padding(
                          padding: EdgeInsets.all(0.02 * screenWidth),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image(
                                  image: AssetImage('assets/item1.jpg'),
                                  width: 60.0,
                                  height: 60.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 0.05 * screenWidth),
                              Text(
                                '$displayItemName',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Color(0xffECB365),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'D',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      'days',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                return Text('Some error occured');
              });
        },
      );
    }
  }
}
