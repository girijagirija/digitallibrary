import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digitallibrary/api/models/book_list_model.dart';
import 'package:digitallibrary/modules/book_list/book_list_controller.dart';
import 'package:digitallibrary/res.dart';
import 'package:digitallibrary/routes/named_routes.dart';
import 'package:digitallibrary/utils/colors.dart';
import 'package:digitallibrary/utils/nettwork_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ListIem extends StatelessWidget {
  final BookDet det;

  final controller = Get.find<BookListcontroller>();

  ListIem({Key? key, required this.det}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: const BoxDecoration(
        color: white,
      ),
      child: Row(
        children: [
      det.imagePath!.isEmpty ?
      Image.asset(Res.errorImage, height: 100, width: 80, fit: BoxFit.contain):
        Image.file(File(det.imagePath!), height: 100, width: 80, fit: BoxFit.contain),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${det.name}',
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 14, color: black, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${det.fileType}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ), // Text(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: SmoothStarRating(
                        color: yellow,
                        borderColor: grey,
                        starCount: 5,
                        rating: det.contentCode == null
                            ? 0.0
                            : double.parse(det.contentCode!.isEmpty
                                ? '0.0'
                                : det.contentCode!),
                        size: 20,
                        allowHalfRating: true,
                      ),
                    ),
                    ElevatedButton.icon(
                        icon: Icon(
                          det.status == 'Add to My Books'
                              ? Icons.add
                              : CupertinoIcons.arrow_turn_up_right,
                          size: 18,
                        ),
                        style: ButtonStyle(
                            // padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 5,vertical: 5)),
                            backgroundColor: MaterialStateProperty.all(
                                det.status == 'Add to My Books'
                                    ? lightBlue
                                    : lightGreen)),
                        onPressed: () async {
                          Get.log('path ${det.imagePath}');
                          if (det.status == 'Add to My Books') {
                            await Get.toNamed(NamedRoutes.addBookForm,
                                arguments: {
                                  'result': controller.connectionStatus.value
                                });
                            controller.initConnectivity();
                          }
                        },
                        label: Text(
                          '${det.status}',
                          style: TextStyle(color: white, fontSize: 12),
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
