import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: EditableAppBar(),
  ));
}

class EditableAppBar extends StatefulWidget {
  const EditableAppBar({super.key});

  @override
  _EditableAppBarState createState() => _EditableAppBarState();
}

class _EditableAppBarState extends State<EditableAppBar> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _Itemcontroller = TextEditingController();
  final TextEditingController _Categorycontroller = TextEditingController();
  final TextEditingController _Descriptioncontroller = TextEditingController();
  String _appBarTitle = 'App Bar';
  String _itemName = 'Item Name';
  String _Category = 'Category';
  String _ItemDescription = 'Item Description';
  //bool _inStock = false;
  int _quantity = 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    return Scaffold(
      backgroundColor: const Color(0xff041C32),
      appBar: AppBar(
        backgroundColor: const Color(0xFF064663),
        title: Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_back_rounded)),
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  decoration: InputDecoration(
                    hintText: _appBarTitle,
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _appBarTitle = value;
                    });
                  },
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.save_rounded)),
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: ListView(scrollDirection: Axis.vertical, children: [
          SizedBox(
            height: 0.02 * screenHeight,
          ),
          SizedBox(
            height: 0.27 * screenHeight,
            child: ListView(
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
          Column(children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 0.06 * screenHeight,
                  left: 0.04 * screenWidth,
                  right: 0.04 * screenWidth,
                  bottom: 0.03 * screenHeight),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _Itemcontroller,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      decoration: const InputDecoration(
                        label: Text('Item Name',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Color(0xFFECB365)),
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {
                          _itemName = text;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 0.05 * screenWidth),
                  Expanded(
                    child: TextField(
                      controller: _Categorycontroller,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      decoration: const InputDecoration(
                        label: Text('Category',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Color(0xFFECB365)),
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {
                          _Category = text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 0,
                  left: 0.04 * screenWidth,
                  right: 0.04 * screenWidth,
                  bottom: 0.03 * screenHeight),
              child: TextField(
                controller: _Descriptioncontroller,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                decoration: const InputDecoration(
                  label: Text(
                    'Item Description',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xFFECB365)),
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    _ItemDescription = text;
                  });
                },
                maxLength: 150,
                maxLines: 3,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Stack(children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.0),
                        bottom: Radius.circular(10.0),
                      ),
                      color: Color(0xFF04293A),
                    ),
                    height: 0.22 * screenHeight,
                    width: screenWidth,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 0.03 * screenHeight,
                      ),
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
                      child: const Center(
                        child: Text('Days for issuing - \'x\' days',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
