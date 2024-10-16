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


    Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'allolab.db');

    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

 static  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE my_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');

    await db.execute(
      '''
CREATE TABLE sync (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    lastSynced DATETIME DEFAULT CURRENT_TIMESTAMP
    )
'''
    );

    await db.execute('''
  insert into sync (name) values("reports");
''');

      await db.execute('''
    CREATE TABLE reports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      reportId TEXT,
      reportType TEXT NOT NULL,
      details TEXT NOT NULL,
      reportFile BLOB,
      created DATETIME DEFAULT CURRENT_TIMESTAMP,
      synced BOOLEAN DEFAULT FALSE,
      imageurl TEXT NOT NULL,
      phone TEXT NOT NULL,
      description TEXT NOT NULL

    );
  ''');

        await db.execute('''
    CREATE TABLE chats (
      id TEXT NOT NULL,
      senderId TEXT NOT NULL,
      receiverid TEXT NOT NULL,
      msg TEXT NOT NULL,
      image TEXT
    );
  ''');

    // await db.execute('''
    //   insert into my_table (name) values("vijay");
    // ''');
  }


    static Future<Database> db() async {
    return await openDatabase(
      'allolab.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await _onCreate(database,version);
        
      },
    );
  }






}