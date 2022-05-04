import 'package:digitallibrary/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_nav_controller.dart';

class BottomNavPage extends StatelessWidget {
  final controller = Get.find<BottomNavcontroller>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: controller.widgets[controller.currentIndex.value],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: bg, boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 5, offset: Offset(0, -1))
          ]),
          child: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              type: BottomNavigationBarType.fixed,
              onTap: (val) => controller.currentIndex.value = val,
              selectedFontSize:12,
              unselectedFontSize: 12,
              iconSize: 30,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined,), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.laptop_outlined,), label: 'Network'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle_outlined,), label: 'Post'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined,), label: 'Resources'),
                BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        Icon(
                          Icons.notifications_outlined,
                        ),
                        Positioned(
                            right: 0,
                            child: new Container(
                              padding: EdgeInsets.all(1),
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: new Text(
                                '5',
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ],
                    ),
                    label: 'Notifications'),
              ]),
        ),
      );
    });
  }
}
