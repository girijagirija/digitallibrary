import 'package:digitallibrary/modules/book_list/widgets/book_list_view.dart';
import 'package:digitallibrary/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'book_list_controller.dart';

class BookListPage extends StatelessWidget {
  final controller = Get.find<BookListcontroller>();

   BookListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.bookListState.value) {
        case ListState.loading:
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
          break;
        case ListState.loaded:
          return DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: Scaffold(
              backgroundColor: bg,
              appBar: controller.searchEnabled.value
                  ? AppBar(
                title: TextFormField(
                  controller: controller.searchController,
                  decoration: const InputDecoration(
                      hintText: 'Search Books..', border: InputBorder.none),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        if (controller.searchController.text.isNotEmpty) {
                          controller.searchController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.close,
                        color: grey,
                      ))
                ],
                backgroundColor: white,
                leading: IconButton(
                  onPressed: () {
                    controller.searchEnabled.value = false;
                  },
                  icon: const Icon(Icons.keyboard_backspace_sharp,color: grey,),
                ),
              )
                  : AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: white,
                leadingWidth: 25,
                leading: const Icon(Icons.chevron_left,color: black,size: 40,),
                title: const Text('Digital Library',style: TextStyle(fontSize: 22,color: black),),
                actions: [
                  IconButton(
                      onPressed: () {
                        controller.searchEnabled.value = true;
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black54,
                      )),
                  const CircleAvatar(
                    backgroundColor: Color(0xff951812),
                    radius: 20,
                    child: Center(child: Text('S',style: TextStyle(color: white))),
                  ),
                  SizedBox(width: 10,)
                ],
              ),
              body: BookListView(),
            ),
          );
          break;
        case ListState.error:
          return const Scaffold(
            body: Center(
              child: Text('Something Went Wrong'),
            ),
          );
          break;
        case ListState.empty:
          return const Scaffold(
            body: Center(
              child: Text('Books Not Found'),
            ),
          );
          break;
        default:
          return Container();
      }

    });
  }
}
