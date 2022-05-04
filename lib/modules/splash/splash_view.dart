import 'package:digitallibrary/res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  final controller = Get.find<Splashcontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(Res.loading_book, height: 200),
            SizedBox(height: 10,),
            Text('Loading..Please Wait',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),),

          ],
        ),
      ),
    );
  }
}
