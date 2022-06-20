import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/clients/clients_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/requests/requests_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> navigationScreens = const <Widget>[
    ClientsScreen(),
    RequestsScreen(),
    SettingsScreen()
  ];

  final List<String> titles = const <String>[
    Strings.clients,
    Strings.requests,
    Strings.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: navigationScreens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: AppColors.grey,
              ),
              activeIcon: Icon(
                Icons.person,
                color: AppColors.primary,
              ),
              label: Strings.clients,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_add,
                color: AppColors.grey,
              ),
              activeIcon: Icon(
                Icons.person_add,
                color: AppColors.primary,
              ),
              label: Strings.requests,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: AppColors.grey,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: AppColors.primary,
              ),
              label: Strings.settings,
            ),
          ],
        ),
      ),
    );
  }
}
