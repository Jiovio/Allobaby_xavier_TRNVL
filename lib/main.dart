import 'package:allobaby/app.dart';
import 'package:allobaby/db/sqlite.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Sqlite.db();
  runApp(const MyApp());
}
