import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:risk_sample/core/logger.dart';
import 'package:risk_sample/core/theme.dart';
import 'package:risk_sample/features/details/domain/detail_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'cammsrisk.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE details(
          id INTEGER PRIMARY KEY,
          recordType TEXT,
          recordCode TEXT,
          recordTitle TEXT,
          reportedBy TEXT,
          reportedDate TEXT,
          dateOccurred TEXT,
          image TEXT
      )
      ''');
  }

  Future<List<Detail>> getDetails() async {
    Database db = await instance.database;
    var details = await db.query('details');
    List<Detail> detailList = details.isNotEmpty
        ? details.map((c) => Detail.fromMap(c)).toList()
        : [];
    return detailList;
  }

  Future<int> add(Detail details) async {
    Database db = await instance.database;
    printLog("DB path --> $db");
    Fluttertoast.showToast(
        msg: "Saved successfully..!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: mainBlue,
        textColor: white,
        fontSize: 16.0);
    return await db.insert('details', details.toMap());
  }

  //! if you want to update record uncomment this

  // Future<int> update(Detail details) async {
  //   Database db = await instance.database;
  //   return await db.update('details', details.toMap(),
  //       where: "id = ?", whereArgs: [details.id]);
  // }
}
