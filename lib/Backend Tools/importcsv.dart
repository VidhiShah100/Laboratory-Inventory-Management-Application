import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

class ImportCSV extends StatefulWidget {
  const ImportCSV({super.key});

  @override
  State<ImportCSV> createState() => _ImportCSVState();
}

class _ImportCSVState extends State<ImportCSV> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              exportData();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 12, 78, 131),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Import CSV files',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void exportData() async {
    final CollectionReference items =
        FirebaseFirestore.instance.collection("items_data");
    final myData = await rootBundle.loadString("assets/items2.csv");

    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);
    List<List<dynamic>> data = [];
    data = csvTable;
    for (var i = 0; i < data.length; i++) {
      var record = {
        "Item name": data[i][0],
        "Item quantity": data[i][1],
        "Item image link": data[i][2],
        "Item product link": data[i][3],
        "Item description": data[i][4],
        "Item price": data[i][5],
        "Sellable?": data[i][6],
        "Return time": data[i][7],
        "UID": data[i][8],
        "Issued To": data[i][9],
        "Past Users": data[i][10]
      };
      items.add(record);
    }
  }
}
