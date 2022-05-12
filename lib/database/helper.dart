import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static const String categoryDBName = 'category';
  static const String walletDBName = 'wallet';
  static const String transactionDBName = 'user_transaction';

  static Future<void> deleteDB() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.deleteDatabase(path.join(dbPath, 'mof.db'));
  }

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'mof.db'),
      version: 1,
      onCreate: (db, version) async {
        db.execute('''
        CREATE TABLE ${DBHelper.categoryDBName} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          icon_id INTEGER,
          is_income INTEGER NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL
        )
      ''');
        db.execute('''
        CREATE TABLE ${DBHelper.walletDBName} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          amount REAL NOT NULL,
          icon_id INTEGER
        )
        ''');
        db.execute('''
        CREATE TABLE ${DBHelper.transactionDBName} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          amount REAL NOT NULL,
          category_id INTEGER NOT NULL,
          wallet_id INTEGER NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          FOREIGN KEY(category_id) REFERENCES ${DBHelper.categoryDBName}(id),
          FOREIGN KEY(wallet_id) REFERENCES ${DBHelper.walletDBName}(id)
        )
        ''');

        db.insert(DBHelper.categoryDBName, {
          'name': 'Transfer In',
          'icon_id': null,
          'is_income': 1,
          'created_at': DateTime.now().toString(),
          'updated_at': DateTime.now().toString(),
        });

        db.insert(DBHelper.categoryDBName, {
          'name': 'Salary',
          'icon_id': null,
          'is_income': 1,
          'created_at': DateTime.now().toString(),
          'updated_at': DateTime.now().toString(),
        });

        db.insert(DBHelper.categoryDBName, {
          'name': 'Bill',
          'icon_id': null,
          'is_income': 0,
          'created_at': DateTime.now().toString(),
          'updated_at': DateTime.now().toString(),
        });

        db.insert(DBHelper.categoryDBName, {
          'name': 'Food',
          'icon_id': null,
          'is_income': 0,
          'created_at': DateTime.now().toString(),
          'updated_at': DateTime.now().toString(),
        });

        db.insert(DBHelper.walletDBName, {
          'name': 'Cash',
          'amount': 0,
          'icon_id': null,
        });

        db.insert(DBHelper.walletDBName, {
          'name': 'Bank',
          'amount': 0,
          'icon_id': null,
        });

        db.insert(DBHelper.walletDBName, {
          'name': 'Other',
          'amount': 0,
          'icon_id': null,
        });

        return;
      },
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final sqlDb = await DBHelper.database();

    await sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDb = await DBHelper.database();

    return sqlDb.query(table);
  }

  static Future<List<Map<String, dynamic>>> rawQuery(String raw,
      [List<Object?>? arguments]) async {
    final sqlDb = await DBHelper.database();

    return sqlDb.rawQuery(raw, arguments);
  }
}
