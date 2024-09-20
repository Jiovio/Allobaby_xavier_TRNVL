import 'package:allobaby/app.dart';
import 'package:allobaby/db/sqlite.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  
  
  await Sqlite.db();
  await initLocalStorage();
  runApp( MyApp());
}
