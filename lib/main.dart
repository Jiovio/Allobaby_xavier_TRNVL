import 'package:allobaby/app.dart';
import 'package:allobaby/db/sqlite.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:get_storage/get_storage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  
  await Sqlite.db();
  await initLocalStorage();
  runApp( MyApp());
}
