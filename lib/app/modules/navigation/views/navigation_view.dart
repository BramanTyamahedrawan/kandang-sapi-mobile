import 'package:crud_flutter_api/app/modules/home/views/home_view.dart';
import 'package:crud_flutter_api/app/modules/menu/menu_view/controllers/menu_controller.dart';
import 'package:crud_flutter_api/app/modules/menu/menu_view/views/menu_view.dart';
import 'package:crud_flutter_api/app/modules/user/views/user_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends StatelessWidget {
  final MainMenuController mainMenuController = Get.put(MainMenuController());
  NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
            child: IndexedStack(
          index: controller.tabIndex,
          children: [
            HomeView(),
            MainMenuView(),
            const UserView(),
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(
              255, 19, 33, 55), // Set your desired background color here
          selectedItemColor: const Color.fromARGB(
              255, 80, 147, 255), // Set the selected item color to white
          unselectedItemColor: const Color.fromARGB(
              255, 255, 255, 255), // Set the unselected item color to white
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: IconTheme(
                data: IconThemeData(
                    color: Colors.white), // Set the icon color to white
                child: Icon(Icons.home),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: IconTheme(
                data: IconThemeData(
                    color: Colors.white), // Set the icon color to white
                child: Icon(Icons.menu_book_rounded),
              ),
              label: 'Data',
            ),
            BottomNavigationBarItem(
              icon: IconTheme(
                data: IconThemeData(
                    color: Colors.white), // Set the icon color to white
                child: Icon(Icons.person),
              ),
              label: 'User',
            ),
          ],
        ),
      );
    });
  }
}
