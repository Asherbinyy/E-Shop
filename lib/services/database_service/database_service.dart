// import 'package:path/path.dart' as p;
// import 'package:sqflite/sqflite.dart';
//
// import 'database_constants.dart';
//
// class DatabaseHelper {
//   DatabaseHelper._();
//
//   static final DatabaseHelper db = DatabaseHelper._();
//
//   static Database? _database;
//
//   Future<Database?> get database async {
//     if (_database != null) {
//       return _database;
//     } else {
//       _database = await initDb();
//       return _database;
//     }
//   }
//
//   Future<Database> initDb() async {
//     final String defaultLocation = await getDatabasesPath();
//     final path = p.join(defaultLocation, "$CART_TABLE.db");
//
//     return openDatabase(path, version: 1, onCreate: _onCreate);
//     // _database.execute(sql)
//   }
//
//   Future<void> _onCreate(Database db, int ver) async{
//     return await db.execute('''
//         CREATE TABLE $CART_TABLE (
//         $CART_P_NAME TEXT NOT NULL,
//         $CART_P_IMAGE TEXT NOT NULL,
//         $CART_P_PRICE INTEGER NOT NULL,
//         $CART_P_QUANTITY INTEGER NOT NULL)
//        ''');
//   }
//
//   Future<void> insert(CartProductModel model) async{
//    final dbClient = await database;
//   final lastId= await dbClient?.insert(CART_TABLE, model.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
//    print("Last row Id added is => $lastId");
//   }
//
//   Future<List<CartProductModel>> getData ()async{
//     List <CartProductModel> cart = [];
//     final dbClient = await database;
//   final data = await dbClient?.query(CART_TABLE);
//     data?.map((map) =>cart.add(CartProductModel.fromJson(map)) ).toList();
//     if (cart.isNotEmpty){
//       return cart;
//     }
//     else {
//       return [] ;
//     }
//   }
//
//   Future<void> clearData ()async{
//     final dbClient = await database;
//   await dbClient?.delete(CART_TABLE);
//   print("ALL DATA WIPED");
//   }
//
// }
