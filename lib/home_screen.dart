import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/fetch_items.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:access_control_flutter/Standard Templates/category_labels.dart';
import 'package:access_control_flutter/Standard Templates/ItemCard.dart';
import 'package:access_control_flutter/itemDescriptionCustomer.dart'; // Import the ItemDescriptionScreen
import 'package:access_control_flutter/ProfileClient.dart';

void main() => runApp(const MaterialApp(
      home: HomeScreen(),
    ));

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<List<ItemsData>> itemsStream;
  List<ItemsData> itemsList = [];
  List<ItemsData> filteredList = [];
  TextEditingController searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    itemsStream = getItems();
    itemsStream.listen((items) {
      setState(() {
        itemsList = items;
        filteredList = items;
      });
    });
  }

  Stream<List<ItemsData>> getItems() {
    Stream<List<ItemsData>> data = FirebaseFirestore.instance
        .collection("items_data")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ItemsData.fromJson(doc.data()))
            .toList());
    return data;
  }

  void filterItems(String query) {
    setState(() {
      searchText = query;
      filteredList = searchItems(itemsList);
    });
  }

  List<ItemsData> searchItems(List<ItemsData> items) {
    if (searchText.isEmpty) {
      return items;
    } else {
      return items
          .where((item) =>
              item.name?.toLowerCase().contains(searchText.toLowerCase()) ??
              false)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(4, 28, 50, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(4, 28, 50, 1),
        elevation: 0,
        title: const Text(
          'IoT Lab',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: filterItems,
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: const Color.fromRGBO(4, 41, 58, 1),
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileClient(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [CategoryLabelsWidget()],
              ),
            ),
          ),
          const SizedBox(height: 16),
          StreamBuilder<List<ItemsData>>(
            stream: itemsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final items =
                    filteredList.isNotEmpty ? filteredList : snapshot.data!;
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(1),
                    childAspectRatio: 0.6, // Adjust the aspect ratio as needed
                    mainAxisSpacing:
                        2.0, // Set the desired spacing between rows
                    crossAxisSpacing:
                        10.0, // Set the desired spacing between columns
                    children: items.map<Widget>((item) {
                      if (item.quantity != 0) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ItemDescriptionScreen(item: item),
                              ),
                            );
                          },
                          child: ItemCard(
                            imageUrl: 'assets/user_image.jpg',
                            itemName: item.name,
                          ),
                        );
                      } else {
                        return const ItemCard(
                          imageUrl: 'assets/user_image.jpg',
                          itemName: "Not Available",
                        );
                      }
                    }).toList(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return Center(
                  child: LoadingAnimationWidget.waveDots(
                    color: const Color.fromRGBO(236, 179, 101, 1),
                    size: 80,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
