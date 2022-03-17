import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  Database db;
  NewsDbProvider() {
    init();
  }

  void init() async {
    //
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");

    //if database open else create a new database
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
      CREATE TABLE Items
        (
          id INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          parent INTEGER,
          kids BLOB,
          dead INTEGER,
          deleted INTEGER, 
          url TEXT, 
          score INTEGER,
          title TEXT,
          descendants INTEGER
        )
      """);
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    // issue a query in our database
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      //return query
      return ItemModel.fromDb(maps.first);
    }

    //else return
    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert('Items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<int>> fetchTopIds() {
    return null;
  }

  Future<int> clear() {
    return db.delete("Items");
  }
}

NewsDbProvider newsDbprovider = NewsDbProvider();
