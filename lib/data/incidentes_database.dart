import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../classes/incidente.dart';

class IncidentesDatabase {
  Database? _database;

  Future<void> init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'incidentes.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE incidentes(
            id TEXT PRIMARY KEY,
            idParque TEXT,
            data TEXT,
            hora TEXT,
            descricao TEXT,
            gravidade INTEGER
          )
        ''');
      },
      version: 1,
    );
  }



  Future<List<Incidente>> getIncidentes() async {
    if (_database == null) {
      throw Exception("Database not initialized");
    }
    List result = await _database!.rawQuery("SELECT * FROM incidentes");
    return result.map((e) => Incidente.fromDB(e)).toList();
  }

  Future<void> insert(Incidente incidente) async {
    if (_database == null) {
      throw Exception("Database not initialized");
    }
    await _database!.insert("incidentes", incidente.toDb());
  }
  Future<List<Incidente>> getIncidentesByParqueId(String idParque) async {
    if (_database == null) {
      throw Exception("Database not initialized");
    }
    List<Map<String, dynamic>> result = await _database!.query(
      'incidentes',
      where: 'idParque = ?',
      whereArgs: [idParque],
    );
    if (result.isNotEmpty) {
      return result.map((e) => Incidente.fromDB(e)).toList();
    } else {
      return [];
    }
  }
  Future<Incidente?> getIncidenteById(String id) async {
    if (_database == null) {
      throw Exception("Database not initialized");
    }
    List<Map<String, dynamic>> result = await _database!.query(
      'incidentes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Incidente.fromDB(result.first);
    } else {
      return null;
    }
  }
}
