import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navigation_exap/sqlFun.dart';

import '../data/data.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  SqlFun _sqlFun = SqlFun();
  final time = DateFormat('yyyy/MM/dd'.replaceAll("/", ""))
      .format(DateTime.now())
      .toString();

  int get date => int.parse(time);
   Future<List<Memo>>? today;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    today = _sqlFun.getTodayList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "오늘 기록한 메모 보기",
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
                  future: today,
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
                                Memo memos = snapshot.data[idx];
                                return ListTile(
                                  title: Text(
                                    memos.title.toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Container(
                                    child: Column(
                                      children: [
                                        Text(memos.memo.toString()),
                                        Container(
                                          height: 1,
                                          color: Colors.blue,
                                        )
                                      ],
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

        ],
      )),
    );
  }
}
