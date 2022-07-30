import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'data/data.dart';

class SqlFun {
  Future<Database> initDatabase()async{
    return openDatabase(
      join(await getDatabasesPath(), "memo.db"),
      onCreate: (db,version){
        return db.execute(
          "CREATE TABLE memo(id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "title TEXT,memo TEXT, date INTEGER)",
        );
      },
      version: 6);
  }



  Future<List<Memo>> getToList()async{
    final database = await initDatabase();
    final maps = await database.query("memo");
    print(maps);
    return List.generate(maps.length, (index){
      return Memo(
        id: int.parse(maps[index]["id"].toString()),
        title: maps[index]["title"].toString(),
        memo: maps[index]["memo"].toString(),
      );
    });
  }

   Future<List<Memo>> getTodayList()async{
    //오늘 작성한 메모 가져오기
     final time = DateFormat('yyyy/MM/dd'.replaceAll("/", "")).format(DateTime.now()).toString();
     final _t = int.parse(time);
     //dateFormat 사용해서 연,월,일 가져오기
     final database = await initDatabase();
     final map = await database.rawQuery(
         "select title, memo, id ,date from memo where date = $_t");
   return List.generate(map.length, (i){
     return Memo(
       id: map[i]["id"] as int,
       title: map[i]["title"].toString(),
       memo: map[i]["memo"].toString(),
       //date: int.parse(map[i]["date"].toString()),
     );
   });
   }

  void insertMemo(Memo memo) async {
    final database = await initDatabase();
    database.insert("memo", memo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  void updateMemo(Memo memo)async{
    final database = await initDatabase();
    await database.update("memo", memo.toMap(), where: "id = ?" ,whereArgs:[memo.id]);
  }
  void deleteMemo(Memo memo)async{
    final database = await initDatabase();
   await database.delete("memo",where: "id = ?", whereArgs: [memo.id]);
  }
  Future<int> insertMap(Memo memo) async{
    final database = await initDatabase();
    if(memo.id == null){
      final map = memo.toMap();
      return  database.insert("memo", map, conflictAlgorithm: ConflictAlgorithm.replace);
    }else{
     final x =  memo.toMap();
      return database.update("memo",x, where: "id = ?" ,whereArgs:[memo.id]);
    }
  }
}
