import 'package:flutter/material.dart';
import 'package:access_control_flutter/models/fetch_items.dart';
import 'package:access_control_flutter/shopping_cart.dart';

class ItemDescriptionScreen extends StatefulWidget {
  final ItemsData item;

  const ItemDescriptionScreen({required this.item, Key? key}) : super(key: key);

  @override
  State<ItemDescriptionScreen> createState() => _ItemDescriptionScreenState();
}

class _ItemDescriptionScreenState extends State<ItemDescriptionScreen> {
  final bool _inStock = true;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    Color appBarBackgroundColor = const Color(0xFF064663);
    Color backgroundColor = const Color(0xff041C32);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          widget.item.name ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        backgroundColor: appBarBackgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(height: 0.02 * screenHeight),
              SizedBox(
                height: 0.27 * screenHeight,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 0.28 * screenWidth),
                    Center(child: Image.asset('assets/stock_img_black.jpg')),
                    SizedBox(width: 0.28 * screenWidth),
                    Center(child: Image.asset('assets/stock_img_blue.jpg')),
                    SizedBox(width: 0.28 * screenWidth),
                    Center(child: Image.asset('assets/stock_img_brown.jpg')),
                    SizedBox(width: 0.28 * screenWidth),
                  ],
                ),
              ),
              Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04),
              child: Row(children: [
                Expanded(
                  flex: 2,
                  child: Text(
                      widget.item.name ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                  ),
                ),
                Text(
                  _inStock ? 'Available' : 'Not Available',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: _inStock ? Colors.green : Colors.red,
                  ),
                  textAlign: TextAlign.left,
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: 0.04 * screenWidth,
                  right: 0.04 * screenWidth),
              child: Text(
                widget.item.description ?? '',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ), 
              Padding(
                padding: EdgeInsets.only(
                  top: 0.02 * screenHeight,
                  left: 0.04 * screenWidth,
                ),
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
                  left: 0.04 * screenWidth,
                  bottom: 0.047 * screenHeight,
                ),
                child: Text(
                  widget.item.price ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.0),
                          bottom: Radius.circular(10.0),
                        ),
                        color: Color(0xFF04293A),
                      ),
                      height: 0.3 * screenHeight,
                      width: screenWidth,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Quantity:',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(width: 5.0),
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle_outline_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_quantity > 1) {
                                  _quantity--;
                                }
                              });
                            },
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0.1 * screenHeight,
                      child: Container(
                        width: screenWidth,
                        height: 0.12 * screenHeight,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF064663),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 0.35 * screenWidth,
                              height: 0.08 * screenHeight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFECB365),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  addToCart();
                                },
                                child: const Text(
                                  'Buy Now',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15.0),
                            SizedBox(
                              width: 0.35 * screenWidth,
                              height: 0.08 * screenHeight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFECB365),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  // addToCart();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CartScreen(
                                        cartItems: [
                                          CartItem(
                                            widget.item.name ?? '',
                                            widget.item.prodLink ?? '',
                                            _quantity,
                                            double.parse(
                                                widget.item.price ?? '0.0'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Issue Now',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addToCart() {
    String priceWithoutSymbol =
        widget.item.price?.replaceAll('\$', '') ?? '0.0';
    double parsedPrice = double.parse(priceWithoutSymbol);

    CartItem newItem = CartItem(
      widget.item.name ?? '',
      widget.item.prodLink ?? '',
      _quantity,
      parsedPrice,
    );

    // Implement your add to cart logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item added to cart'),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          cartItems: [newItem],
        ),
      ),
    );
  }
}
