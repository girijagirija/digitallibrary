import 'dart:convert';

import 'package:digitallibrary/api/models/book_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Repository {
  Future<String?> post() async {
    String url ='http://15.206.132.105/ulektzConnectNew/campusAPI/api.php';
    Get.log('url -$url');

    Map<String, String> body = {
      "functionName": "elibraryBookStore",
      "page": "1",
      "size": "",
      "instId": "132",
      "userId": "192277",
      "searchTxt": ""
    };
    Get.log('body -$body');

    try {
      var response = await http.post(Uri.parse(url), body: jsonEncode(body));
      Get.log('response -${response.body}');
      Get.log('Status Code -${response.statusCode}');

      if(response.statusCode == 200){
        return response.body;
      }else{
        return '';
      }

    } on Exception catch (e) {
      Get.log('http error -$e');
      return null;
    }
  }

  Future<BookListModel?> getBookList() async {
    return bookListModelFromJson(await post());
  }
}
