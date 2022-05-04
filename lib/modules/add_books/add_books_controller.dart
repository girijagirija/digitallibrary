import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digitallibrary/api/models/book_list_model.dart';
import 'package:digitallibrary/utils/colors.dart';
import 'package:digitallibrary/utils/keys.dart';
import 'package:digitallibrary/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class AddBookscontroller extends GetxController {
  TextEditingController bookName = TextEditingController();
  var imagePath = ''.obs;
  var status = 0.obs;

  ConnectivityResult connectivityResult = Get.arguments['result'];

  var rating = 0.0.obs;
  var btnLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (rating.value == 0.0) {
        ToastUtils.showToast('Please Select Rating..!', red);
      } else if (status.value == 0) {
        ToastUtils.showToast('Please Select Status..!', red);
      } else if (imagePath.value.isEmpty) {
        ToastUtils.showToast('Please Select File..!', red);
      } else {
        btnLoading.value = true;
        addBook();
      }
    }
  }

  addBook() async {

    if (connectivityResult == ConnectivityResult.none) {
      Get.log('add local');
      var box = Hive.box<BookDet>(Keys.bookDetBox);
      var res = box.add(BookDet(
          name: bookName.text,
          contentCode: rating.value.toString(),
          contentType: rating.value.toString(),
          status: status.value == 1 ? 'Add to My Books' : 'Go to My Books',
          fileType: 'PDF',
          imagePath: imagePath.value));
    } else {
      Get.log('to add firebase');
      final bookREf = FirebaseFirestore.instance
          .collection('books')
          .withConverter<BookDet>(
            fromFirestore: (snapshot, _) => BookDet.fromJson(snapshot.data()!),
            toFirestore: (book, _) => book.toJson(),
          );
      bookREf.add(BookDet(
          name: bookName.text,
          contentCode: rating.value.toString(),
          contentType: rating.value.toString(),
          status: status.value == 1 ? 'Add to My Books' : 'Go to My Books',
          fileType: 'PDF',
          imagePath: imagePath.value));
    }

    Get.back();
    ToastUtils.showToast('Added Successfully..', green);
    btnLoading.value = false;
  }

  pickImage(bool isCamera) async {
    XFile? xfile = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (xfile != null) {
      imagePath.value = xfile.path;
    }
    Get.log('path -${imagePath.value}');
  }
}
