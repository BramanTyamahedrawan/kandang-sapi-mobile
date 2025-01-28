import 'package:crud_flutter_api/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserView extends StatelessWidget {
  static String routeName = "/profile";

  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    UserController userController = Get.find<UserController>();
    return GetBuilder<UserController>(builder: (controller) {
      return Scaffold(
        backgroundColor: const Color(0xffF7EBE1),
        appBar: AppBar(
          title: const Text(
            'My Profile',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            textAlign: TextAlign.center,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 19, 33, 55),
          elevation: 0.0,
        ),
        body: Container(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const CircleAvatar(
                  radius: 70,
                ),
                const SizedBox(height: 20),
                itemProfile(
                    'Username',
                    '${userController.box.read('username')}',
                    CupertinoIcons.person),
                const SizedBox(height: 10),
                itemProfile('Name', '${userController.box.read('name')}',
                    CupertinoIcons.person_3_fill),
                const SizedBox(height: 10),
                itemProfile('Role', '${userController.box.read('role')}',
                    CupertinoIcons.person_2_square_stack_fill),
                const SizedBox(height: 10),
                itemProfile('Email', '${userController.box.read('email')}',
                    CupertinoIcons.mail),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.box.remove('token');
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text('LOG OUT'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: const Color.fromARGB(255, 0, 47, 255).withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}
