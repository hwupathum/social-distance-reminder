import 'package:social_distance_reminder/model/beacon.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BeaconDatabase {
  static final BeaconDatabase instance = BeaconDatabase._init();

  static Database? _database;

  BeaconDatabase._init();

  Future<Database> get database async {
    if (database != null) return _database!;

    _database = await _initDB('beacons.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final stringType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableBeacons (
    ${BeaconFields.id} $idType,
    ${BeaconFields.name}, $stringType
    )
    ''');
  }

  Future<Beacon> create(Beacon beacon) async {
    final db = await instance.database;

    final id = await db.insert(tableBeacons, beacon.toJson());
    return beacon.copy(id: id);
  }

  Future<Beacon> readBeacon(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBeacons,
      columns: BeaconFields.values,
      where: '${BeaconFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Beacon.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<Beacon>> readAllBeacons() async {
    final db = await instance.database;
    final orderBy = '${BeaconFields.name} ASC';
    final result = await db.query(tableBeacons, orderBy: orderBy);

    return result.map((json) => Beacon.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
      tableBeacons,
      where: '${BeaconFields.id} = ?',
      whereArgs: [id],
    );
  }
}