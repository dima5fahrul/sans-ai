import 'package:flutter/material.dart';
import 'package:sansai_mobile/screens/group_screen.dart';
import 'package:sansai_mobile/screens/profile_screen.dart';

import '../components/fab_bottom_bar_item.dart';
import '../shared/my_colors.dart';
import 'create_grup_screen.dart';
import 'home_screen.dart';

class NavbarView extends StatefulWidget {
  const NavbarView({super.key});

  @override
  State<NavbarView> createState() => _NavbarViewState();
}

class _NavbarViewState extends State<NavbarView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Visibility(
        visible: true,
        child: Visibility(
          visible: _currentIndex == 1,
          child: FloatingActionButton(
            heroTag: 'fab',
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateGroupScreen())),
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: MyColors.primaryColor),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ),
        ),
      ),
      bottomNavigationBar: FABBottomBar(
        iconSize: 32,
        color: Colors.grey,
        selectedColor: MyColors.primaryColor,
        backgroundColor: Colors.white,
        onTabSelected: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          FABBottomBarItem(icon: 'assets/icons/home-icon.png', title: 'Home'),
          FABBottomBarItem(icon: 'assets/icons/group-icon.png', title: 'Grup'),
          FABBottomBarItem(
              icon: 'assets/icons/history-icon.png', title: 'Riwayat'),
          FABBottomBarItem(
              icon: 'assets/icons/user-icon.png', title: 'Profile'),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          GroupScreen(),
          HomeScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
