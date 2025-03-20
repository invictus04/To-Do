import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  ///singleton
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();
  static final String TABLE_NAME = "note";
  static final String COLUMN_SNO = "Sno";
  static final String COLUMN_TITLE = "Title";
  static final String COLUMN_DESC = "Description";

  Database? myDB;

  /// db Open(path -> if exists then open else create db)
  Future<Database> getDB() async {
   myDB ??= await openDB();
   return myDB!;
    // if (myDB != null) {
    //   return myDB!;
    // } else {
    //   myDB = await openDB();
    //   return myDB!;
    // }
  }

  Future<Database> openDB() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String dbPath = join(directory.path, "noteDB.db");

    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute(
          "create table $TABLE_NAME ($COLUMN_SNO integer primary key autoincrement, $COLUMN_TITLE text, $COLUMN_DESC text)",
        );
      },
      version: 1,
    );
  }

  ///all queries
  ///insertion
  Future<bool> addNote({required String mTitle, required String mDesc}) async{
    var db = await getDB();
    
    int rowsAffected = await db.insert(TABLE_NAME, {
      COLUMN_TITLE : mTitle,
      COLUMN_DESC : mDesc
    });
    return rowsAffected>0;
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async{
    var db = await getDB();

    List<Map<String, dynamic>> mData = await db.query(TABLE_NAME);

    return mData;
  }

  Future<bool> updateNote({required String mTitle, required String mDesc, required int sno}) async{
    var db = await getDB();

    var rowsAffected = await db.update(TABLE_NAME, {COLUMN_TITLE: mTitle, COLUMN_DESC: mDesc},where: "$COLUMN_SNO = $sno");
    return rowsAffected>0;
  }


  Future<bool> deleteNote({required int sno}) async{
    var db = await getDB();

    int rowsAffected = await db.delete(TABLE_NAME, where: "$COLUMN_SNO = $sno");
    return rowsAffected>0;

  }


}
