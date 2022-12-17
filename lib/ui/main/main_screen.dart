import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vendor/const.dart';
import 'package:vendor/ui/main/home_screen/home_screen.dart';
import 'package:vendor/ui/main/notification_screen/notification_screen.dart';
import 'package:vendor/ui/main/other_screen/other_screen.dart';
import 'package:vendor/ui/main/scanner_screen/scanner_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = const <Widget>[
    HomeScreen(),
    ScannerScreen(),
    OtherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LineIcons.bell),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  const NotificationScreen(),),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: primaryColor.withOpacity(.5),
              color: Colors.black,


              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.camera,
                  text: 'Scanner',
                ),
                GButton(
                  icon: Icons.more_horiz_outlined,
                  text: 'Other',
                ),/*
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),*/
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (i) {
                setState(() {
                  _selectedIndex = i;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
