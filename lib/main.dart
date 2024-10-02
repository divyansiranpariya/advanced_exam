
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Views/components/databseComponent.dart';
import 'Views/components/firebase_notes.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(
        name: '/',
        page: () => HomePage(),
      ),
      GetPage(
        name: '/FirebaseNotes',
        page: () => FirebaseNotes(),
      ),
    ],
  ));
}
