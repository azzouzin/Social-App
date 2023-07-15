// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Messege {
  final String senderid;
  final String recieverid;
  final String text;
  final String date;
  final String? imgurl;
  Messege(
      {required this.senderid,
      required this.recieverid,
      required this.text,
      required this.date,
      this.imgurl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderid': senderid,
      'recieverid': recieverid,
      'text': text,
      'date': date,
      'imgurl': imgurl,
    };
  }

  factory Messege.fromMap(Map<String, dynamic> map) {
    return Messege(
      senderid: map['senderid'] as String,
      recieverid: map['recieverid'] as String,
      text: map['text'] as String,
      date: map['date'] as String,
      imgurl: map['imgurl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Messege.fromJson(String source) =>
      Messege.fromMap(json.decode(source) as Map<String, dynamic>);
}
