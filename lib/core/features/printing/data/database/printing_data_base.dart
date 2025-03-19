import 'package:ngu_app/app/app_config/data_base_constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class PrintingDataBase {
  Future<Database> initDatabase();
  Future<Database> get database;
}

class PrintingDataBaseImpl implements PrintingDataBase {
  Database? _database;

  @override
  Future<Database> get database async {
    _database ??= await initDatabase();
    // _database!.delete(DataBaseConstant.printingTable);
    return _database!;
  }

  @override
  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DataBaseConstant.databaseName),
      version: DataBaseConstant.databaseVersion,
      onCreate: (db, _) {
        db.execute('''
          CREATE TABLE ${DataBaseConstant.printingTable}(
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
