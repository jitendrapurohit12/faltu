import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faltu/constants/constants.dart';
import 'package:faltu/models/individual/individual_product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabaseHelper {
  static ProductDatabaseHelper _helper;
  static Database _database;

  String tableName = 'product_table';
  String colId = 'id';
  String colName = 'name';
  String colColor = 'color';
  String colPrice = 'price';
  String colDiscount = 'discount';
  String colUnits = 'units';
  String colType = 'type';
  String colImages = 'images';
  String colSize = 'size';
  String colDetailsId = 'details_id';
  String colCategory = 'category';

  ProductDatabaseHelper._createInstance();

  factory ProductDatabaseHelper() {
    if (_helper == null) {
      _helper = ProductDatabaseHelper._createInstance();
    }
    return _helper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'product.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableName($colId ${Constants.TEXT} PRIMARY KEY, $colName ${Constants.TEXT}, '
        '$colColor ${Constants.TEXT}, $colPrice ${Constants.TEXT}, $colDiscount ${Constants.TEXT}, '
        '$colUnits ${Constants.TEXT}, $colType ${Constants.TEXT}, $colImages ${Constants.TEXT}, '
        '$colSize ${Constants.TEXT}, $colDetailsId ${Constants.TEXT}, $colCategory ${Constants.TEXT})');
  }

  Future<List<Map<String, dynamic>>> getProductMapList(
      {type: String, category: String, gender :String}) async {
    Database db = await this.database;

    if (type != null)
      return await db.query(tableName,
          where: '$colType = ? AND $colCategory = ?',
          whereArgs: [type, category]);
    else
      return await db.query(tableName, where: '$colCategory = ?', whereArgs: [category]);
  }

  void insertProducts(QuerySnapshot snapshot) {
    List<DocumentSnapshot> list = snapshot.documents;

    list.forEach((snap) async {
      var db = await this.database;
      await db.insert(
          tableName, IndividualProduct.getProductForSqFlite(snap.data),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateProducts(IndividualProduct product) async {
    var db = await this.database;
    var result = await db.update(tableName, product.toJson(),
        where: '$colId = ?', whereArgs: [product.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteProduct(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $tableName WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> checkProductRefresh(int id) async {
    Database db = await this.database;
    List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT MAX ($colId) FROM $tableName');

    int maxId = int.parse(maps[0]['MAX (id)'] ?? '0');

    print('MAX ID IS $maxId');

    return maxId;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<IndividualProduct>> getProductList(
      {type: String, category: String, gender : String}) async {
    var productList = await getProductMapList(type: type,category: category,gender: gender);

    List<IndividualProduct> noteList = List<IndividualProduct>();

    productList.forEach((product) {
      noteList.add(IndividualProduct.getProductFromSqlite(product));
    });

    return noteList;
  }
}
