import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newspaper/controller/news_controller.dart';
import 'package:newspaper/view/bbc.dart';
import 'package:newspaper/view/science.dart';
import 'package:newspaper/view/sports_page.dart';


class HomePage extends GetWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
   Get.put(NewsController());
    List<Widget> screens = [
      const BBCPage(),
      const SportsPage(),
      const SciencePage(),
    ];
    return GetBuilder<NewsController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('News App'),
            actions: [
              IconButton(onPressed: ()async{
                GoogleSignIn google=GoogleSignIn();
                google.disconnect();
                await FirebaseAuth.instance.signOut();
                Get.offAllNamed("login");
              }, icon: const Icon(Icons.exit_to_app_outlined))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black,
            currentIndex:controller.currentIndex,
            onTap: controller.onChange,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports),
                label: 'Sports',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.science),
                label: 'Science',
              ),
            ],
          ),
          body:  screens.elementAt(controller.currentIndex),
        );
      }
    );
  }
}
