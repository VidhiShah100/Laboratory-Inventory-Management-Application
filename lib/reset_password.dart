import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromRGBO(4, 41, 58, 1),
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(4, 28, 50, 1),
      body: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(10, 150, 10, 200),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
            decoration: BoxDecoration(
           color: const Color.fromRGBO(4, 41, 58, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: 
                Text(
                  'Reset Your Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                ),
                const SizedBox(height: 26.0),
                TextField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Enter new password',
                    hintStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: const Color.fromRGBO(6, 70, 99, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    hintStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: const Color.fromRGBO(6, 70, 99, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      String newPassword = _newPasswordController.text;
                      String confirmPassword = _confirmPasswordController.text;

                      if (newPassword == confirmPassword) {
                        Navigator.pop(context, true);
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('Passwords do not match.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromRGBO(236, 179, 101, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('Change Password',style: TextStyle(fontWeight: FontWeight.w800),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}








