import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navigation_exap/sqlFun.dart';

import '../data/data.dart';

class AddPage extends StatefulWidget {
  Memo? memo;
   AddPage({Key? key,this.memo}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  Memo? get memo => widget.memo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(memo != null){
    titleController.text = widget.memo!.title.toString();
    memoController.text = widget.memo!.memo.toString();
    }else{
      titleController.text ="";
      memoController.text = "";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("addPage"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "제목",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: memoController,
            decoration: InputDecoration(
              hintText: "메모",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () async{
                    final time = DateFormat('yyyy/MM/dd'.replaceAll("/", "")).format(DateTime.now()).toString();
                    final t= int.parse(time);
                    Memo memos  = Memo(
                      id: widget.memo?.id,
                      title: titleController.text,
                      memo: memoController.text,
                      date: t,
                    );
                    Navigator.of(context).pop(memos);
                  },
                  child: Text("저장"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
