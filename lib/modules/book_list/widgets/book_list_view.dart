import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digitallibrary/api/models/book_list_model.dart';
import 'package:digitallibrary/modules/book_list/book_list_controller.dart';
import 'package:digitallibrary/modules/book_list/widgets/list_item.dart';
import 'package:digitallibrary/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookListView extends StatelessWidget {
  BookListView({Key? key}) : super(key: key);
  final controller = Get.find<BookListcontroller>();

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Tab(
        text: 'eBook',
      ),
      Tab(
        text: 'Videos',
      ),
      Tab(
        text: 'Others',
      ),
      Tab(
        text: 'Downloads',
      ),
    ];

    return Column(
      children: [
        TabBar(
          tabs: tabs,
          // isScrollable: true,
          labelColor: black54,
          labelStyle: const TextStyle(color: black54),
          indicatorColor: blue,
          indicatorWeight: 3,
        ),
        // Center(child: Text('${controller.connectionStatus.value == ConnectivityResult.none ? 'From Local Storage' : 'Firebase'}')),
        GetBuilder<BookListcontroller>(builder: (controller) {
          return Expanded(
            child:SmartRefresher(
              controller: RefreshController(),
              onRefresh: controller.initConnectivity,
              child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 5,),
                  // separatorBuilder: (context, index) => Divider(thickness: 1,),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: controller.searchbookList.length ,
                  itemBuilder: (context, index) {
                    BookDet bookDet = controller.searchbookList[index];
                    return ListIem(det: bookDet);
                  }),

            )          );
        }),
        SizedBox(height: 10,)
      ],
    );
  }
}
