import 'dart:typed_data';

import 'package:access_control_flutter/Standard Templates/Text_field.dart';
import 'package:access_control_flutter/Backend Tools/signup_methods.dart';
import 'package:access_control_flutter/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Backend Tools/pick_image.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  void submitForm() async {
    setState(() {
      _isLoading = true;
    });
    String? response;
    if (_formKey.currentState!.validate()) {
      response = await AuthMethods().SignUp(
          firstname: _firstnameController.text,
          lastname: _lastnameController.text,
          password: _passwordController.text,
          confirmpassword: _confirmpasswordController.text,
          email: _emailController.text,
          file: _image!);
    }
    if (response == 'success') {
      print("success");
    } else {
      print(response);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => (const HomeScreen())));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();

    super.dispose();
  }

  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromRGBO(4, 28, 50, 1), // Set background color to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 68,
                        backgroundColor: Colors.red,
                        child: CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        ),
                      )
                    : const CircleAvatar(
                        radius: 68,
                        backgroundColor: Colors.red,
                        child: CircleAvatar(
                          radius: 64,
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
            const SizedBox(height: 24.0),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(
                    4, 41, 58, 1), // Set container color to grey
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Input first name
                    TextFieldInput(
                        textEditingController: _firstnameController,
                        hintText: "First Name",
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 24,
                    ),

                    //Input Last Name
                    TextFieldInput(
                        textEditingController: _lastnameController,
                        hintText: "Last Name",
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 24,
                    ),

                    // Input email
                    TextFieldInput(
                        textEditingController: _emailController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 24,
                    ),

                    //Input Password
                    TextFieldInput(
                      textEditingController: _passwordController,
                      hintText: "Password",
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    //Input Confirm Password
                    TextFieldInput(
                      textEditingController: _confirmpasswordController,
                      hintText: "Confirm Password",
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      onPressed: submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: const Color.fromRGBO(236, 179, 101, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Container(
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : const Text(
                                '                                 Sign Up                                 ',
                                style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: () {
                        // Forgot password functionality
                      },
                      child: const Text('Forgot Password?',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  // Widget _buildTextField(String label, {required bool isPassword}) {
  //   return TextFormField(
  //     controller: isPassword ? _passwordController : _emailController,
  //     obscureText: isPassword,
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter a ${isPassword ? 'password' : 'valid email'}';
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: label,
  //       border: InputBorder.none,
  //       filled: true,
  //       fillColor: Colors.white,
  //       labelStyle: const TextStyle(
  //           color: Colors.black), // Set text color to solid black
  //     ),
  //   );
  // }
}
