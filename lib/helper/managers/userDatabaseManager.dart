import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:izmalogintask/appCore/login/models/userLoginModel.dart';

class UserDatabaseManager {
  // Database name and version constants
  static const databaseName = "users_login_database.db";
  static const databaseVersion = 1;

  UserDatabaseManager._privateConstructor();
  static final UserDatabaseManager instance = UserDatabaseManager._privateConstructor();


  late Database _database;

  // Getter to access the database
  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    // Get the path to the databases directory
    String path = join(await getDatabasesPath(), databaseName);
    // Join the path with the database name to create the complete database path
    return await openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }


  // Create the userLogins tables in the database
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE userLogins (
        email TEXT PRIMARY KEY,
        password TEXT,
        login_count INTEGER
      )
    ''');
  }

  // Insert or update a user login record
  Future<void> insertOrUpdateUserLogin(UserLoginModel userLogin) async {
    final db = await instance.database;
    await db.insert(
      'userLogins',
      userLogin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve a user login record based on email
  Future<UserLoginModel?> getUserLogin(String email, String password) async {
    final db = await instance.database;
    final maps = await db.query(
      'userLogins',
      where: 'email = ?',
      whereArgs: [email, password],
    );

    // If a matching record is found, return a UserLoginModel instance
    if (maps.isNotEmpty) {
      return UserLoginModel.fromMap(maps.first);
    }
    // If no matching record is found, return null
    return null;
  }
}
