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
      reportType TEXT ,
      details TEXT ,
      reportFile BLOB,
      created DATETIME DEFAULT CURRENT_TIMESTAMP,
      synced BOOLEAN DEFAULT FALSE,
      imageurl TEXT ,
      phone TEXT ,
      description TEXT 

    );
  ''');

await db.execute('''
CREATE TABLE chats (
  id TEXT NOT NULL,
  senderId TEXT NOT NULL,
  receiverId TEXT NOT NULL,
  type TEXT,
  message TEXT,
  timestamp TIMESTAMP NOT NULL,
  photoUrl TEXT,
  fileUrl TEXT,
  fileSize TEXT,
  fileName TEXT,
  fid TEXT
);
''');

  await db.execute('''
    CREATE TABLE chatlist (
      name TEXT,
      fid TEXT,
      id TEXT,
      type TEXT,
      lastMessage TEXT,
      recent TIMESTAMP
    );
  ''');


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