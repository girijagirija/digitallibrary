import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digitallibrary/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import 'add_books_controller.dart';

class AddBooksPage extends StatelessWidget {
  final controller = Get.find<AddBookscontroller>();

   AddBooksPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: black),
        title: const Text(
          'Add Book',
          style: const TextStyle(color: black),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Form(
          key: controller.formKey,
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: controller.bookName,
                    validator: (val) => val!.isEmpty ? 'Enter Book Name' : null,
                    decoration: const InputDecoration(
                      hintText: 'Book Name',
                      labelText: 'Book Name',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Rate:',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SmoothStarRating(
                    color: yellow,
                    borderColor: grey,
                    starCount: 5,
                    rating: controller.rating.value,
                    onRatingChanged: (val) => controller.rating.value = val,
                    size: 40,
                    allowHalfRating: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Status:',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  RadioListTile<int>(
                      value: 1,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: 0),
                      groupValue: controller.status.value,
                      title: const Text('Add To My Books'),
                      onChanged: (val) => controller.status.value = val!),
                  RadioListTile<int>(
                      value: 2,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: 0),
                      groupValue: controller.status.value,
                      title: const Text('Go to My Books'),
                      onChanged: (val) => controller.status.value = val!),
                controller.imagePath.value.isNotEmpty
                    ? Image.file(
                  File(
                    controller.imagePath.value,
                  ),
                  height: 100,
                  width: 100,
                )
                    : Container(),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(orange)),
                      onPressed: () {
                        Get.bottomSheet(
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Select Image',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Get.back();
                                        controller.pickImage(true);
                                      },
                                      leading: const Icon(Icons.camera_outlined),
                                      title: const Text('Camera'),
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: 0),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Get.back();
                                        controller.pickImage(false);
                                      },
                                      leading: const Icon(Icons.photo_outlined),
                                      title: const Text('Gallery'),
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: 0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            backgroundColor: white);
                      },
                      child: const Text(
                        'Upload',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                  SizedBox(height: 30,),
                Obx((){
                  return   controller.btnLoading.value
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.submit();
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )),
                  );
                })
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
