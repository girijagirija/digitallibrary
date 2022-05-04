
import 'package:digitallibrary/modules/add_books/add_books_binding.dart';
import 'package:digitallibrary/modules/add_books/add_books_view.dart';
import 'package:digitallibrary/modules/book_list/book_list_binding.dart';
import 'package:digitallibrary/modules/book_list/book_list_view.dart';
import 'package:digitallibrary/modules/bottom_nav/bottom_nav_binding.dart';
import 'package:digitallibrary/modules/bottom_nav/bottom_nav_view.dart';
import 'package:digitallibrary/modules/splash/splash_binding.dart';
import 'package:digitallibrary/modules/splash/splash_view.dart';
import 'package:digitallibrary/routes/named_routes.dart';
import 'package:get/get.dart';

final List<GetPage> pages = [

  GetPage(name: NamedRoutes.splash, page: ()=>SplashPage(),binding: SplashBinding()),
  GetPage(name: NamedRoutes.bookList, page: ()=>BookListPage(),binding: BookListBinding()),
  GetPage(name: NamedRoutes.addBookForm, page: ()=>AddBooksPage(),binding: AddBooksBinding()),
  GetPage(name: NamedRoutes.bottomNavPage, page: ()=>BottomNavPage(),binding: BottomNavBinding()),

];