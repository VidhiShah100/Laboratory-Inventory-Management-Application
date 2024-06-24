import 'package:access_control_flutter/Sign_up.dart';
import 'package:access_control_flutter/home_screen.dart';
import 'package:access_control_flutter/ProfileClient.dart';
import 'package:access_control_flutter/requested_items.dart';
import 'package:access_control_flutter/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const SignUpPage(),
    RequestedItemsScreen(),
    const ProfileClient(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int i) {
    _pageController.jumpToPage(i);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool showBottomNavigationBar = true;

    if (_currentIndex == 1) {
      showBottomNavigationBar = false;
    }

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: showBottomNavigationBar
          ? ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomAppBar(
                color: const Color.fromRGBO(6, 70, 99, 1),
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 0.0), // Adjust the spacing as desired
                  child: Container(
                    color: const Color.fromRGBO(6, 70, 99, 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: GNav(
                        rippleColor: const Color.fromARGB(255, 9, 45, 75),
                        hoverColor: const Color.fromARGB(255, 7, 60, 85),
                        gap: 8,
                        tabBorderRadius: 40,
                        backgroundColor: const Color.fromRGBO(6, 70, 99, 1),
                        color: Colors.white,
                        activeColor: Colors.white,
                        tabBackgroundColor: const Color.fromRGBO(4, 53, 75, 1),
                        selectedIndex: _currentIndex,
                        onTabChange: _onItemTapped,
                        tabs: const [
                          GButton(
                            icon: Icons.home,
                            text: 'Home',
                          ),
                          GButton(
                            icon: Icons.shopping_cart,
                            text: 'Cart',
                          ),
                          GButton(
                            icon: Icons.list_alt,
                            text: 'Item List',
                          ),
                          GButton(
                            icon: Icons.person,
                            text: 'Profile',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
