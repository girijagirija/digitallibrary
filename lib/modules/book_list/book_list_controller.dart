import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digitallibrary/api/models/book_list_model.dart';
import 'package:digitallibrary/api/repository.dart';
import 'package:digitallibrary/utils/colors.dart';
import 'package:digitallibrary/utils/keys.dart';
import 'package:digitallibrary/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

enum ListState { loading, loaded, error, empty }

class BookListcontroller extends GetxController {
  var bookListState = ListState.loading.obs;

  List<BookDet> bookList = [];
  List<BookDet> searchbookList = [];
   var imagePath = ''.obs;

  var connectionStatus = ConnectivityResult.none.obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  var searchEnabled = false.obs;
  TextEditingController searchController = TextEditingController();

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    bookListState.value = ListState.loading;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      Get.log('Couldn\'t check connectivity status $e', isError: true);
      bookListState.value = ListState.error;
      return;
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    bookListState.value = ListState.loading;
    connectionStatus.value = result;
    ToastUtils.showToast(
        '${connectionStatus.value == ConnectivityResult.none ? 'Fetching From Local!' : 'Fetching From Online'}.',
        orange);
    Get.log('connectionStatus.value -${connectionStatus.value}');
    getBookList();
  }

  getBookList() async {
    if (connectionStatus.value == ConnectivityResult.none) {
      try {
        Get.log('Fetching from local storage');
        var box = Hive.box<BookDet>(Keys.bookDetBox);
        bookList = box.values.toList();
        searchbookList = box.values.toList();
      } on Exception catch (e) {
        Get.log('list error -$e');
        bookListState.value = ListState.error;
      }
    } else if (connectionStatus.value == ConnectivityResult.mobile ||
        connectionStatus.value == ConnectivityResult.wifi ||
        connectionStatus.value == ConnectivityResult.ethernet) {
      Get.log('Fetching from firebase');
      final bookREf = FirebaseFirestore.instance
          .collection('books')
          .withConverter<BookDet>(
            fromFirestore: (snapshot, _) => BookDet.fromJson(snapshot.data()!),
            toFirestore: (book, _) => book.toJson(),
          );
      List<QueryDocumentSnapshot<BookDet>> queryBookList = await bookREf.get().then((snapshot) => snapshot.docs);
      List<BookDet> fetchList = [];
      for (var element in queryBookList) {
        fetchList.add(element.data());
        bookList = fetchList;
        searchbookList = fetchList;

      }
    }
    if (searchbookList.isNotEmpty) {
      Get.log('searchbookList -${searchbookList.length}');
      bookListState.value = ListState.loaded;
    } else {
      bookListState.value = ListState.empty;
    }
  }


  @override
  void onInit() {
    ///for search
    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        searchbookList = bookList.where((element) {
          return element.name!
              .toLowerCase()
              .contains(searchController.text.toLowerCase());
        }).toList();
      } else {
        searchbookList = bookList;
      }
      update();
    });
    super.onInit();
  }

  @override
  void onReady() {
    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }





}
