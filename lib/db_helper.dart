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

  // Initialize the database
  initDb() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'finance_manager.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        // Create users table
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            password TEXT
          )
        ''');

        // Create transactions table
        await db.execute('''
          CREATE TABLE transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            amount REAL,
            description TEXT,
            category TEXT,
            date TEXT,
            FOREIGN KEY (user_id) REFERENCES users(id)
          )
        ''');

        // Create budget table
        await db.execute('''
          CREATE TABLE budgets (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            category TEXT,
            budget_limit REAL,
            spent REAL,
            FOREIGN KEY (user_id) REFERENCES users(id)
          )
        ''');

        // Create savings goals table
        await db.execute('''
          CREATE TABLE savings_goals (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            goal_name TEXT,
            goal_amount REAL,
            saved_amount REAL,
            FOREIGN KEY (user_id) REFERENCES users(id)
          )
        ''');
      },
    );
  }

  // User-specific data methods
  Future<void> registerUser(String email, String password) async {
    var dbClient = await db;
    await dbClient.insert('users', {'email': email, 'password': password});
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    var dbClient = await db;
    var result = await dbClient.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // Transaction methods
  Future<void> addTransaction(
      int userId, double amount, String description, String category) async {
    var dbClient = await db;
    await dbClient.insert('transactions', {
      'user_id': userId,
      'amount': amount,
      'description': description,
      'category': category,
      'date': DateTime.now().toString()
    });
  }

  Future<List<Map<String, dynamic>>> getUserTransactions(int userId) async {
    var dbClient = await db;
    return await dbClient
        .query('transactions', where: 'user_id = ?', whereArgs: [userId]);
  }

  // Budget methods
  Future<void> addBudget(int userId, String category, double limit) async {
    var dbClient = await db;
    await dbClient.insert('budgets', {
      'user_id': userId,
      'category': category,
      'budget_limit': limit,
      'spent': 0.0
    });
  }

  Future<List<Map<String, dynamic>>> getUserBudgets(int userId) async {
    var dbClient = await db;
    return await dbClient
        .query('budgets', where: 'user_id = ?', whereArgs: [userId]);
  }

  // Savings methods
  Future<void> addSavingsGoal(
      int userId, String goalName, double goalAmount) async {
    var dbClient = await db;
    await dbClient.insert('savings_goals', {
      'user_id': userId,
      'goal_name': goalName,
      'goal_amount': goalAmount,
      'saved_amount': 0.0
    });
  }

  Future<List<Map<String, dynamic>>> getUserSavingsGoals(int userId) async {
    var dbClient = await db;
    return await dbClient
        .query('savings_goals', where: 'user_id = ?', whereArgs: [userId]);
  }
}
