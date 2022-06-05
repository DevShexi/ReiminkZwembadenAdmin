import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/data/repositories/admin_repository.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/clients/clients_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/requests/requests_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/home/settings/settings_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_elevated_button.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_outlined_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AdminRepository _adminRepository = GetIt.I<AdminRepository>();
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
        backgroundColor: AppColors.backgroundGrey,
        appBar: _currentIndex != 1
            ? AppBar(
                title: Text(
                  titles[_currentIndex],
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              7.0,
                            ),
                          ),
                          content: SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset("assets/svg/alert.svg"),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      Strings.logout,
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  Strings.logoutPromptMessage,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CustomOutlinedButton(
                                        label: Strings.cancel,
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: CustomElevatedButton(
                                        label: Strings.logout,
                                        onPressed: () {
                                          _adminRepository.logout();
                                          Navigator.pop(context, false);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              )
            : null,
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
