import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'users.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT UNIQUE,
            phone TEXT,
            password TEXT,
            profileImage TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertUser(String name, String email, String phone, String password, String profileImage) async {
    final db = await database;
    await db.insert(
      'users',
      {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'profileImage': profileImage
      },
    );
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;
    final users = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return users.isNotEmpty ? users.first : null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }
}