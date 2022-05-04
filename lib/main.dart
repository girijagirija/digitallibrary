import 'dart:io';

import 'package:digitallibrary/api/models/book_list_model.dart';
import 'package:digitallibrary/modules/splash/splash_binding.dart';
import 'package:digitallibrary/routes/named_routes.dart';
import 'package:digitallibrary/routes/pages.dart';
import 'package:digitallibrary/utils/keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  await Firebase.initializeApp();
  Directory dir = await getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter<BookListModel>(BookListModelAdapter());
  Hive.registerAdapter<Output>(OutputAdapter());
  Hive.registerAdapter<Result>(ResultAdapter());
  Hive.registerAdapter<BookDet>(BookDetAdapter());
  await Hive.openBox<BookListModel>(Keys.bookListBox);
  await Hive.openBox<BookDet>(Keys.bookDetBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Digital Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: NamedRoutes.splash,
      initialBinding: SplashBinding(),
      getPages: pages,

      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
