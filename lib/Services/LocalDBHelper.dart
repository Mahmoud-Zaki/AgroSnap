import 'package:agrosnap/Models/PlantCare.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'PlantsCare.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE PlantsCare (id INTEGER PRIMARY KEY, name TEXT, waterizationDate TEXT, waterizationTime TEXT, fertilizationDate TEXT, fertilizationTime TEXT, harvestDate TEXT, harvestTime TEXT, otherName TEXT, otherDate TEXT, otherTime TEXT, waterizationDate2 TEXT, waterizationTime2 TEXT, fertilizationDate2 TEXT, fertilizationTime2 TEXT, harvestDate2 TEXT, harvestTime2 TEXT, otherDate2 TEXT, otherTime2 TEXT, waterizationRepeat TEXT, waterizationRepeat2 TEXT, fertilizationRepeat TEXT, fertilizationRepeat2 TEXT, harvestRepeat TEXT, harvestRepeat2 TEXT, otherRepeat TEXT, otherRepeat2 TEXT)');
  }

  Future<int> add(PlantCare plant) async{
    var dbClient = await db;
    return await dbClient!.insert('PlantsCare', plant.toMap());
  }

  Future<void> update(PlantCare plant) async {
    var dbClient = await db;
    await dbClient!.update(
      'PlantsCare',
      plant.toMap(),
      where: 'id = ?',
      whereArgs: [plant.id],
    );
  }

  Future<List> getMainPlants({required bool arabic}) async{
    var dbClient = await db;
    List result = await dbClient!.query('PlantsCare',
      columns: (arabic)?['id','name','waterizationDate','fertilizationDate','harvestDate','otherName','otherDate']
          :['id','name','waterizationDate2','fertilizationDate2','harvestDate2','otherName','otherDate2'],
    );
    return result;
  }

  Future<PlantCare> getPlantDetails({required int id}) async{
    var dbClient = await db;
    List result = await dbClient!.query('PlantsCare', where: 'id = ?', whereArgs: [id]);
    if(result.length>0)
      return PlantCare.fromMap(result.first);
    return PlantCare(name: "");
  }

  Future<List> getTodayPlants({required String con,required bool arabic}) async{
    var dbClient = await db;
    List result = await dbClient!.query('PlantsCare',
      columns: ['id','name','waterizationTime','waterizationTime2','fertilizationTime','fertilizationTime2','harvestTime','harvestTime2','otherName','otherTime','otherTime2'],
      where: 'waterizationDate2 = ? OR fertilizationDate2 = ? OR harvestDate2 = ? OR otherDate2 = ?',
      whereArgs: [con,con,con,con]
    );
    return result;
  }

  Future<void> delete(int id) async {
    var dbClient = await db;
    await dbClient!.delete(
      'PlantsCare',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

//  Future<void> close() async {
//    var dbClient = await db;
//    dbClient!.close();
//  }
}