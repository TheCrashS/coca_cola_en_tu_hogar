import 'package:sqflite/sqflite.dart';
import "package:path/path.dart" show join;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('usuarios.db');
    return _database!;
  }

  // Inicializa la base de datos
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Crea la tabla de usuarios
        await db.execute('''
          CREATE TABLE usuarios(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            direccion TEXT NOT NULL,
            celular TEXT NOT NULL,
            contrasena TEXT NOT NULL,
            fecha TEXT
          )
        ''');
      },
    );
  }

  // Inserta un nuevo usuario
  Future<int> insert(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('usuarios', row);
  }

  // Obtiene un usuario por nombre y contraseña
  Future<Map<String, dynamic>?> getUserByNameAndPassword(String nombre, String contrasena) async {
    final db = await instance.database;
    final res = await db.query(
      'usuarios',
      where: 'nombre = ? AND contrasena = ?',
      whereArgs: [nombre, contrasena],
    );
    return res.isNotEmpty ? res.first : null;
  }
}
