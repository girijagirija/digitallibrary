import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitallibrary/api/models/book_list_model.dart';
import 'package:digitallibrary/api/repository.dart';
import 'package:digitallibrary/routes/named_routes.dart';
import 'package:digitallibrary/utils/keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';

class Splashcontroller extends GetxController {
  List<BookDet> bookList = [];

  @override
  void onInit() {
    addInitialDb();
    super.onInit();
  }

  addInitialDb() async {
    var box = Hive.box<BookDet>(Keys.bookDetBox);
    if (box.values.toList().isEmpty) {
      Get.log('added into local Db');
      bookList = (await getBooks())!;
      if (bookList.isNotEmpty) {
        for (var element in bookList) {
          String image = await downloadImage(element.imagePath!);
          box.add(BookDet(
            name: element.name,
            imagePath: image,
            fileType: element.fileType,
            status: element.status,
            contentType: element.contentType,
            contentCode: element.contentCode,
            id: element.id,
          ));
        }
      }
    }
    initAddFirBase();
    await Future.delayed(const Duration(seconds: 4));
    Get.offAllNamed(NamedRoutes.bottomNavPage);
  }

  initAddFirBase() async {
    final bookREf = FirebaseFirestore.instance
        .collection('books')
        .withConverter<BookDet>(
          fromFirestore: (snapshot, _) => BookDet.fromJson(snapshot.data()!),
          toFirestore: (book, _) => book.toJson(),
        );
    List<QueryDocumentSnapshot<BookDet>> book =
        await bookREf.get().then((snapshot) => snapshot.docs);
    if (book.isEmpty) {
      Get.log('initially added to firebase');
      bookList = (await getBooks())!;
      bookList.forEach((element) async {
        String image = await downloadImage(element.imagePath!);
        await bookREf.add(BookDet(
          name: element.name,
          imagePath: image,
          fileType: element.fileType,
          status: element.status,
          contentType: element.contentType,
          contentCode: element.contentCode,
          id: element.id,
        ));
      });
    }
    print('book list-${book.length}');
  }

  Future<String> downloadImage(String imagUrl) async {
    String filename = Uri.parse(imagUrl).pathSegments.last;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    if (file.existsSync()) {
      print(file.path);
      return file.path;
    } else {
      var request = await http.get(
        Uri.parse(imagUrl),
      );
      var bytes = request.bodyBytes; //close();
      await file.writeAsBytes(bytes);
      return file.path;
    }
  }

  Future<List<BookDet>?> getBooks() async {
    BookListModel? bookListModel = await Repository().getBookList();
    if (bookListModel != null &&
        bookListModel.output!.result!.status == "success") {
      if (bookListModel.output!.result!.bookDet!.isNotEmpty) {
        return bookListModel.output!.result!.bookDet;
      } else {
        return [];
      }
    } else {
      return null;
    }
  }

}
