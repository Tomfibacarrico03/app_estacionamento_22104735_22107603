import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

import "../classes/estacionamento.dart";

class PARQUESDatabase {
  Database? _database;

  Future<void> init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'parques.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE estacionamento(
            nome TEXT PRIMARY KEY,
            id TEXT NULL,
            capacidade_max INTEGER NOT NULL,
            ocupacao INTEGER NOT NULL,
            tipo TEXT,
            distancia DECIMAL,
            preco DECIMAL,
            data_ocupacao TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<List<Estacionamento>> getEstacionamentos() async {
    if (_database == null) {
      throw Exception("Forgot to initialize the database");
    }
    List result = await _database!.rawQuery("SELECT * FROM estacionamento");

    return result.map((e) => Estacionamento.fromDB(e)).toList();
  }

  Future<void> insert(Estacionamento estacionamento) async{
    if (_database == null) {
      throw Exception("Forgot to initialize the database");
    }
    await _database!.insert("estacionamento", estacionamento.toDb());
  }

  Future<Estacionamento?> getEstacionamentoByNome(String nome) async {
    if (_database == null) {
      throw Exception("Forgot to initialize the database");
    }
    List<Map<String, dynamic>> result = await _database!.query(
      'estacionamento',
      where: 'nome = ?',
      whereArgs: [nome],
    );

    if (result.isNotEmpty) {
      return Estacionamento.fromDB(result.first);
    } else {
      return null;
    }
  }

  Future<void> update(Estacionamento estacionamento) async {
    if (_database == null) {
      throw Exception("Forgot to initialize the database");
    }
    await _database!.update(
      'estacionamento',
      estacionamento.toDb(),
      where: 'nome = ?',
      whereArgs: [estacionamento.nome],
    );
  }
}
