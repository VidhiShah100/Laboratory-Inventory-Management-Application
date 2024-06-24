import 'dart:typed_data';
import 'package:access_control_flutter/Backend%20Tools/pick_image.dart';
import 'package:access_control_flutter/ProfileClient.dart';
import 'package:access_control_flutter/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var temp;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUserUid() {
    final User? user = _auth.currentUser;
    return user?.uid ?? '';
  }

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  Uint8List? _image;

  void _logout() async {
    await _auth.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      _firstnameController.text =
          (snap.data() as Map<String, dynamic>)["firstname"];
      _emailController.text = (snap.data() as Map<String, dynamic>)["email"];
      _lastnameController.text =
          (snap.data() as Map<String, dynamic>)["firstname"];
      _image = (snap.data() as Map<String, dynamic>)["photoUrl"];
    });
  }

  void _saveChanges() async {
    await _firestore.collection('users').doc(getCurrentUserUid()).update({
      "firstname": _firstnameController.text,
      "lastname": _lastnameController.text,
      "email": _emailController.text,
      "photoUrl": _image,
    });
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const ProfileClient()));
  }

  @override
  Widget build(BuildContext context) {
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

            // final int Previous = userData?['Previous'] ?? '';

            return Scaffold(
              backgroundColor: const Color(0xff041C32),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                backgroundColor: Color(0xffECB365),
                                radius: 72,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1687789903381-d2e97615f06a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                                ),
                              ),
                        Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: MediaQuery.of(context).size.height - 300,
                      decoration: const BoxDecoration(
                        color: Color(0xff04293A),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10),
                          _buildField('FirstName', _firstnameController),
                          const SizedBox(height: 20),
                          _buildField('LastName', _lastnameController),
                          const SizedBox(height: 20),
                          _buildField('Email', _emailController),
                          // const SizedBox(height: 20),
                          // _buildField('Phone', _phoneController),
                          const Spacer(),
                          SizedBox(
                            height: 60,
                            child: ElevatedButton(
                              onPressed: _logout,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffECB365),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: const Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 60,
                            child: ElevatedButton(
                              onPressed: _saveChanges,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffECB365),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                              child: const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
        });
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextFormField(
                controller: controller,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                onChanged: (newValue) {
                  temp = newValue;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter new value',
                  border: InputBorder
                      .none, // Remove the border below the text field
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
