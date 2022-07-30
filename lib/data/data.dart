

class Memo{
  int? id;
  String? title;
  String? memo;
  int? date;

  Memo({this.id,this.title,this.memo,this.date});

  Map<String,dynamic>toMap(){
    return {
      "id":id,
      "title":title,
      "memo" : memo,
      "date":date,
    };
  }
}