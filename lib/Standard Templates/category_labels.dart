import 'package:flutter/material.dart';

class CategoryLabelsWidget extends StatefulWidget {
  const CategoryLabelsWidget({super.key});

  @override
  State<CategoryLabelsWidget> createState() => _CategoryLabelsWidgetState();
}

class _CategoryLabelsWidgetState extends State<CategoryLabelsWidget> {
  int _selectedIndex = 0;
  final List<String> _categories = [
    'All',
    'Circuit Boards',
    'Sensors',
    'Motors',
    'LEDs'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildCategoryLabels(),
    );
  }

  List<Widget> _buildCategoryLabels() {
    return List.generate(
      _categories.length,
      (index) => GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: index == _selectedIndex
                ? const Color.fromRGBO(236, 179, 101, 1)
                : const Color.fromRGBO(6, 70, 99, 1),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: const EdgeInsets.all(5),
          child: Text(
            _categories[index],
            style: TextStyle(
              color: index == _selectedIndex ? Colors.white : Colors.white,
              fontWeight:
                  index == _selectedIndex ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
