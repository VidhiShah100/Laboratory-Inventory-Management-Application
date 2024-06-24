import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(const MaterialApp(
    home: LoadingScreen(),
  ));
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(4, 28, 50, 1),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: SizedBox(
            width: 0.8 * screenWidth,
            child: Image.network(
                'https://i.postimg.cc/hv3R78Th/Brain-Pump-2-cropped.jpg'),
          )),
          Center(
            child: LoadingAnimationWidget.waveDots(
              color: const Color.fromRGBO(236, 179, 101, 1),
              size: 80,
            ),
          ),
        ],
      )),
    );
  }
}
