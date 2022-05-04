import 'package:get/get.dart';

import 'book_list_controller.dart';

class BookListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookListcontroller());
  }
}
