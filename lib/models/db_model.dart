import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'todo_model.dart';

class DatabaseConnect {
  Database? _database;

  Future<Database> get database async {
    // location of the database in device
    final dbpath = await getDatabasesPath();
    // name of the database
    const dbname = 'todo.db';
    // the dbpath and dbname are joined to create a full path for the database
    final path = join(dbpath, dbname);

    // opens the connection
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    return _database!;
  }

  // this function creates the database
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE TODO(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        creationDate TEXT,
        isChecked INTEGER
      )
    ''');
  }

  // this function inserts data into the tables in the database
  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    // insert the todo
    await db.insert(
      'todo', // the table name
      todo.toMap(), // this is a function used from todo_model
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // this function deletes data from the database based on the id
  Future<void> deleteTodo(Todo todo) async {
    final db = await database;
    await db.delete(
      'todo',
      where: 'id == ?',
      whereArgs: [todo.id],
    );
  }

  // this function retrieves all data in the database and displays the as a list
  // of maps
  Future<List<Todo>> getTodo() async {
    final db = await database;
    List<Map<String, dynamic>> items = await db.query(
      'todo',
      orderBy: 'id DESC',
    );

    // this function converts the list maps to a format which can be displayed
    // in a list
    return List.generate(
      items.length,
      (i) => Todo(
        id: items[i]['id'],
        title: items[i]['title'],
        isChecked: items[i]['isChecked'] == 1 ? true : false,
      ),
    );
  }
}
