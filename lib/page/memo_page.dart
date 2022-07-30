import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navigation_exap/page/add_page.dart';
import 'package:navigation_exap/sqlFun.dart';
import 'package:navigation_exap/sqlFun.dart';
import 'package:navigation_exap/today_page/today_page.dart';

import '../data/data.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  final sql = SqlFun();
  Future<List<Memo>>? memoList;

  @override
  void initState() {
    // memo: implement initState
    super.initState();
    memoList = sql.getToList();
    //print("겟 리스트 : ${sql.getToList()}");
  }
  @override
  Widget build(BuildContext context) {
    final time = DateFormat('yyyy/mm/dd'.replaceAll("/", "")).format(DateTime.now()).toString();
    sql.initDatabase();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async{
          final memo = await Navigator.of(context).pushNamed("/addPage");
           sql.insertMemo(memo as Memo);
          setState((){
            memoList = sql.getToList();
          });
        },child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "메모",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Center(
              child: FutureBuilder(
              future: memoList,
              builder: (context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, idx) {
                            Memo memo = snapshot.data[idx];
                            return GestureDetector(
                              onDoubleTap: (){
                                sql.deleteMemo(memo);
                                setState((){
                                  memoList = sql.getToList();
                                });
                              },
                              onTap: () async{
                                final m = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPage(
                                  memo: Memo(
                                    id:memo.id,title: memo.title,memo: memo.memo,
                                  ),
                                )));
                                if(m != null){
                                 sql.updateMemo(m);
                                }
                                setState((){
                                  memoList = sql.getToList();
                                });
                              },
                              child: ListTile(
                                title: Text(
                                  memo.title.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                subtitle: Container(
                                  child: Column(
                                    children: [
                                      Text(memo.memo.toString()),
                                      Container(
                                        height: 1,
                                        color: Colors.blue,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    return CircularProgressIndicator();
                }
              }),
    ),
            ),
            Row(
              children: [Expanded(child: ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                TodayPage()));
              },child: Text("오늘 쓴 글 보기"),))],
            )
          ],
        ))
    );
  }
}
