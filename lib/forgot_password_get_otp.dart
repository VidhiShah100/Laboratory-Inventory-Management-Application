import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

class ResetPwd extends StatelessWidget {
  const ResetPwd({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: EmailVerificationPage(),
    );
  }
}

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpVerified = false;

  void _getOtp() {
    setState(() {
      _isOtpVerified = true;
    });
  }

  void _confirmOtp() {
    String enteredOtp = _otpController.text;
    // Perform OTP verification logic here
    // For demonstration purposes, let's just print the entered OTP
    print('Entered OTP: $enteredOtp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(4, 28, 50, 1),
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(4, 41, 58, 1),
      ),
      body: Center(
        child: Container(
          height: 350,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(
                4, 41, 58, 1), // Set container color to grey
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 37, 34, 34).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: !_isOtpVerified
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Enter your email ID',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(

                        filled: true,
                        fillColor: const Color.fromRGBO(6, 70, 99, 1),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color:  Color.fromRGBO(6, 70, 99, 1), // Set border color
                            width: 0.0, // Set border thickness
                          ),
                          borderRadius:
                              BorderRadius.circular(20.0), // Set border radius
                        ),
                        labelText: 'Email Address',
                        labelStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: 300, // Set the desired width
                      child: ElevatedButton(
                        onPressed: _getOtp,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set border radius
                          ),
                          backgroundColor:
                              const Color.fromRGBO(236, 179, 101, 1),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'GET OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Email: ${_emailController.text}',
                      style: const TextStyle(
                        color: Color.fromRGBO(236, 179, 101, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _otpController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter OTP',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _confirmOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Confirm OTP',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
