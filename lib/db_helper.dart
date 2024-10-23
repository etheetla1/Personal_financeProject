import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'finance_manager.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            password TEXT,
            biometric_enabled INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE income_expense (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            description TEXT,
            category TEXT,
            type TEXT,
            date TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE budget (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            budget_limit REAL,
            spent REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE savings_goal (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            goal_name TEXT,
            goal_amount REAL,
            saved_amount REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE settings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            dark_mode INTEGER,
            export_format TEXT
          )
        ''');
      },
    );
  }

  // CRUD methods here (e.g., insertUser, getIncomeExpense, updateBudget, etc.)
}
