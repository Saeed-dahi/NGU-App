import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class PrintingDataBase {
  Future<Database> initDatabase();
  Future<Database> get database;
}

class PrintingDataBaseImpl implements PrintingDataBase {
  final String _databaseName = 'ngu';
  final String _tableName = 'printing_table';
  final int _databaseVersion = 1;
  Database? _database;

  @override
  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  @override
  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: (db, _) {
        db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            url TEXT NOT NULL,
            name TEXT NOT NULL,
            printer_type TEXT
          )
        ''');
      },
    );
  }
}
