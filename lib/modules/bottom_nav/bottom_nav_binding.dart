import 'package:digitallibrary/modules/book_list/book_list_controller.dart';
import 'package:get/get.dart';

import 'bottom_nav_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavcontroller());
    Get.lazyPut(() => BookListcontroller());
  }
}
