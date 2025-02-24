import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class Sqlite {
static final Sqlite _instance = Sqlite._internal();
  static Database? _database;

    factory Sqlite() {
    return _instance;
  }

  Sqlite._internal();


   static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'allobaby.db');

    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      singleInstance: true
    );
  }


  static Future<Database> db() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

 static  Future<void> _onCreate(Database db, int version) async {

  try {

      await db.execute('''
CREATE TABLE dailyscreening (
    id INTEGER PRIMARY KEY,
    date DATE NOT NULL,
    feeling TEXT,
    glassOfWater INTEGER,
    bedTime TEXT,
    wakeUpTime TEXT,
    sleepDuration INTEGER,
    exercises TEXT,
    tabletsTaken TEXT,
    symptoms TEXT,
    created DATETIME DEFAULT CURRENT_TIMESTAMP
    );
''');


  await db.execute('''
CREATE TABLE symptoms (
    data TEXT NOT NULL,
    date DATE DEFAULT (DATE('now')) PRIMARY KEY,
    synced BOOLEAN DEFAULT 0,
    uid INTEGER
);
''');

  await db.execute('''
CREATE TABLE vitals (
    data TEXT NOT NULL,
    date DATE DEFAULT (DATE('now')) PRIMARY KEY,
    synced BOOLEAN DEFAULT 0,
    uid INTEGER
);
''');

  await db.execute('''
CREATE TABLE daily (
    data TEXT NOT NULL,
    date DATE DEFAULT (DATE('now')) PRIMARY KEY,
    synced BOOLEAN DEFAULT 0,
    uid INTEGER
);
''');
    
  } catch (e) {

    print(e);

    print("DB Initialization Error $e");
    
  }

    



  }









}