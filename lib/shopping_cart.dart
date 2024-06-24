import 'package:access_control_flutter/home_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotalPrice();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(4, 28, 50, 1),
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(4, 41, 58, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: ((context) => const HomeScreen())),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                return buildCartItem(widget.cartItems[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 12.0,
                ); // Adjust the height as desired
              },
            ),
          ),
          Container(
            color: const Color.fromRGBO(6, 70, 99, 1),
            padding: const EdgeInsets.all(26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Implement your buy now functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    backgroundColor: const Color.fromRGBO(236, 179, 101, 1),
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCartItem(CartItem item) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          // Remove the item from the cartItems list
          widget.cartItems.remove(item);
        });
        // Show a snackbar or perform any other action on dismissal
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item removed from cart'),
          ),
        );
      },
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(right: 16),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0), // Apply border radius
          child: Container(
            color: const Color.fromRGBO(
                6, 70, 99, 1), // Set the background color to red
            // padding: const EdgeInsets.all(
            // 16.0), // Apply padding to the item container
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  item.prodLink,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Price: \$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          item.quantity++;
                        });
                      },
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      iconSize: 30,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                      splashRadius: 16,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.amber,
                      focusColor: Colors.blue,
                      visualDensity: VisualDensity.compact,
                    ),
                    Text(
                      item.quantity.toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (item.quantity > 1) {
                            item.quantity--;
                          } else {
                            widget.cartItems.remove(item);
                          }
                        });
                      },
                      icon: const Icon(Icons.remove),
                      color: Colors.white,
                      iconSize: 30,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                      splashRadius: 16,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.amber,
                      focusColor: Colors.blue,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (CartItem item in widget.cartItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }
}

class CartItem {
  final String name;
  final String prodLink;
  int quantity;
  final double price; // Update the type to double

  CartItem(
    this.name,
    this.prodLink,
    this.quantity,
    this.price,
  );

  // Add any additional methods or properties as needed
}