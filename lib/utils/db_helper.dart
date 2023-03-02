import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db_helper {
  static Db_helper db_helper =Db_helper();
  Database? database;

  Future<Database?> cheackDb() async {
    if (database != null) {
      return database;
    } else {
      return await createDb();
    }
  }

  Future<Database> createDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'quotes.db');
    return openDatabase(onCreate: (db, version) {
      String quary =
          "CREATE TABLE quotes(id INTEGER PRIMARY KEY AUTOINCREMENT,cat TEXT,quote TEXT,author TEXT)";
      db.execute(quary);
    }, version: 1, path);
  }

  void insertData(
      {required String cat,
      required String quote,
      required String author}) async {
    database = await cheackDb();
    database!.insert('quotes', {"cat": cat, "quote": quote, "author": author});
  }

  Future<List<Map>> readData({required id}) async {
    database = await cheackDb();

    String query = "SELECT * FROM quotes WHERE id = $id";

    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  Future<List<Map>> readAllData() async {
    database = await cheackDb();

    String query = "SELECT * FROM quotes";

    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }
  Future<void> deletedata({required id}) async {
    database = await cheackDb();

    database!.delete('quotes',where: "id = ?",whereArgs: [id]);
  }
}
