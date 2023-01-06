import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbConfig {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else
      return _db;
  }

  initialDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'database.db');
    Database Mydb = await openDatabase(path,
        onCreate: _onCreate, version: 7, onUpgrade: _onUpgrade);
    return Mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    print("onUpgrade");
    //DeleteDb();
    //await db.execute("ALTER TABLE produit ADD COLUMN stock TEXT");
    //await db.execute("ALTER TABLE user ADD COLUMN gender TEXT");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "user"( 
    uid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    pwd TEXT NOT NULL,
    name TEXT NOT NULL,
    role TEXT,
    unique(username,pwd)
    ) ''');
    await db.execute('''
    CREATE TABLE "produit"( 
    pid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    pname TEXT NOT NULL,
    code TEXT NOT NULL,
    ref TEXT,
    fournisseurID TEXT,
    cat TEXT,
    prix TEXT,
    stock TEXT,
    prixVente TEXT,
    designation TEXT,
    addedDate TEXT,
    unique(code)
    ) ''');

    await db.execute('''
    CREATE TABLE "vente"( 
    vid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    nbrArticle TEXT,
    numFacture TEXT,
    total TEXT,
    addedDate TEXT,
    unique(numFacture)
    ) ''');

    await db.execute('''
    CREATE TABLE "ligneCommande"( 
    vid TEXT NOT NULL,
    pid TEXT NOT NULL,
    quantité TEXT NOT NULL
    ) ''');

    await db.execute('''
    CREATE TABLE "fournisseur"( 
    fid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    fname TEXT NOT NULL,
    fcode TEXT NOT NULL,
    adresse TEXT,
    debit TEXT,
    credit TEXT,
    balance TEXT
    ) ''');

    await db.execute('''
    CREATE TABLE "client"( 
    cid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    cname TEXT NOT NULL,
    code TEXT NOT NULL,
    location TEXT,
    debit TEXT,
    credit TEXT,
    balance TEXT
    ) ''');

    await db.execute('''
    CREATE TABLE "currentStock"( 
    pname TEXT NOT NULL,
    pcode TEXT NOT NULL,
    quantité TEXT
    ) ''');

    print("Create database and tables*********************************");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  DeleteDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'database.db');
    await deleteDatabase(path);
  }
}
