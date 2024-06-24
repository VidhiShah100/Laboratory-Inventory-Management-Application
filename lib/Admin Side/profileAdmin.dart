import 'package:flutter/material.dart';

class AccessReq {
  final String name;
  final String imagePath;

  AccessReq({
    required this.name,
    required this.imagePath,
  });
}

class ProfilePageAdmin extends StatefulWidget {
  const ProfilePageAdmin({super.key});

  @override
  ProfilePageAdminState createState() => ProfilePageAdminState();
}

class ProfilePageAdminState extends State<ProfilePageAdmin> {
  final List<AccessReq> accessReq = [
    AccessReq(name: 'Lorem', imagePath: 'assets/stock_img_black.jpg'),
    AccessReq(name: 'Ipsum', imagePath: 'assets/stock_img_black.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Color(0xFF064663),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.all(0.02 * screenHeight),
            child: Stack(children: [
              Container(
                width: screenWidth,
                height: 0.25 * screenHeight,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              Positioned(
                top: 0.15 * screenHeight,
                left: 0.1 * screenWidth,
                child: Container(
                  child: const Column(
                    children: [
                      Text(
                        'Lorem Ipsum',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Admin',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                ),
              ),
              Positioned(
                right: 10,
                top: 0.175 * screenHeight,
                child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/item1.jpg')),
              )
            ]),
          ),
          Positioned(
              top: 0.3 * screenHeight,
              left: 0.02 * screenHeight,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 0.09 * screenHeight,
                      width: 0.09 * screenHeight,
                      color: Colors.blueGrey,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.group_add_rounded),
                      ),
                    ),
                  ),
                  SizedBox(width: 0.02 * screenWidth),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 0.09 * screenHeight,
                      width: 0.09 * screenHeight,
                      color: Colors.blueGrey,
                      child: const Center(
                        child: Text(
                          'History',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
              top: 0.43 * screenHeight,
              // left: 0.02 * screenHeight,
              // right: 0.02 * screenHeight,
              child: Column(
                children: [
                  const Text(
                    'Access Requests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                      width: screenWidth,
                      height: double.maxFinite,
                      child: ListView.builder(
                        itemCount: accessReq.length,
                        itemBuilder: (context, index) {
                          AccessReq accessReqs = accessReq[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              child: Padding(
                                  padding: EdgeInsets.all(0.02 * screenWidth),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Image(
                                          image:
                                              AssetImage(accessReqs.imagePath),
                                          width: 60.0,
                                          height: 60.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 0.05 * screenWidth),
                                      Text(accessReqs.name),
                                      SizedBox(width: 0.3 * screenWidth),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.check_rounded)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.close_rounded)),
                                    ],
                                  )),
                            ),
                          );
                        },
                      )),
                ],
              )),
          Positioned(
              bottom: 0.01 * screenHeight,
              right: 0.01 * screenWidth,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.brightness_4),
              ))
        ]),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ProfilePageAdmin(),
  ));
}
