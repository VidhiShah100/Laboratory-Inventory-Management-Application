import 'package:access_control_flutter/Backend%20Tools/issuedItemList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'editProfile.dart';

class ProfileClient extends StatefulWidget {
  const ProfileClient({super.key});

  @override
  ProfileClientState createState() => ProfileClientState();
}

class ProfileClientState extends State<ProfileClient> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUserUid() {
    final User? user = _auth.currentUser;
    return user?.uid ?? '';
  }

  void text() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => (const EditProfilePage())));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    return StreamBuilder(
      stream:
          _firestore.collection('users').doc(getCurrentUserUid()).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("No data found"),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          final Map<String, dynamic> userData =
              (snapshot.data?.data() as Map<String, dynamic>);
          final String firstname = userData['firstname'] ?? '';
          final String email = userData['email'] ?? '';
          // final int Previous = userData?['Previous'] ?? '';
          final List issuedItems = ((userData['issueditems'] ?? []));
          final String PhotoUrl = userData['PhotoUrl'];
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xFF041C32),
              body: Stack(children: [
                Padding(
                  padding: EdgeInsets.all(0.02 * screenHeight),
                  child: Stack(children: [
                    Container(
                      width: screenWidth,
                      height: 0.25 * screenHeight,
                      decoration: const BoxDecoration(
                        color: Color(0xff04293A),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    Positioned(
                      top: 0.15 * screenHeight,
                      left: 0.1 * screenWidth,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              firstname,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              email,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Text(
                              'Student',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Request for Admin Access successful")));
                            },
                            icon: const Icon(
                              Icons.group_add,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfilePage()));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 0.175 * screenHeight,
                      child: CircleAvatar(
                        backgroundColor: Color(0xffECB365),
                        radius: 64,
                        child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(PhotoUrl)),
                      ),
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
                            height: 0.1 * screenHeight,
                            width: 0.1 * screenHeight,
                            color: const Color(0xff04293A),
                            child: const Center(
                              child: Text(
                                'Dues',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 0.05 * screenWidth),
                        // Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 0.1 * screenHeight,
                            width: 0.1 * screenHeight,
                            color: const Color(0xff04293A),
                            child: const Center(
                              child: Text(
                                'History',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                    top: 0.43 * screenHeight,
                    child: Column(
                      children: [
                        const Text(
                          'Issued Items',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                            color: Colors.blueAccent,
                            width: screenWidth,
                            height: double.maxFinite,
                            child: IssuedList(issuedlist: issuedItems)),
                      ],
                    )),
                Positioned(
                    bottom: 0.01 * screenHeight,
                    right: 0.01 * screenWidth,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.brightness_4,
                        color: Colors.white,
                      ),
                    ))
              ]),
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
        return const Text("Some error occured");
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ProfileClient(),
  ));
}
