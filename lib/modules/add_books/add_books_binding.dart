import 'package:get/get.dart';

import 'add_books_controller.dart';

class AddBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddBookscontroller());
  }
}
