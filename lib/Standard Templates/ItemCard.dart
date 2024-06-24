import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String imageUrl;
  final String? itemName;

  const ItemCard({Key? key, required this.imageUrl, required this.itemName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(6, 70, 99, 1),
              borderRadius: BorderRadius.circular(19.0),
            ),
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            width: 200,
            height: 300,
            // padding: const EdgeInsets.only(bottom: 1),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(11.0),
                  child: Image.asset(
                    imageUrl,
                    width: 200.0,
                    height: 250.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    itemName ?? 'Default Value',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow
                        .ellipsis, // Specify the desired overflow behavior
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
