import 'package:digitallibrary/modules/book_list/book_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomNavcontroller extends GetxController {
  final widgets = [
    BookListPage(),
    Container(child: Center(child: Text('Network'),)),
    Container(child: Center(child: Text('Post'),)),
    Container(child: Center(child: Text('Resources'),)),
    Container(child: Center(child: Text('Notifications'),)),

  ];

  var currentIndex = 0.obs;
}
