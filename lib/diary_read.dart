import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';


class DiaryReadPage extends StatefulWidget {
  DiaryReadPage({required this.diaryId});
  
  final String diaryId;

  @override
  State<DiaryReadPage> createState() => _MyDiaryReadPageState();
}

class _MyDiaryReadPageState extends State<DiaryReadPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  String title = '';
  String content = '';
  String link = '';

  void initState() {
    super.initState();
    getDiaryData();
  }

  getDiaryData() async {
    var result = await FirebaseFirestore.instance.collection('diary').doc(widget.diaryId).get();
    if (result.exists) {
      setState(() {
        title = result["title"];
        content = result["content"];
        link = result["link"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 0, 113),
      ),
    body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: 
        Column( //수직 배열
          children: <Widget>[
            const SizedBox(height: 20.0),
            Container( //제목 칸을 담을 컨테이너
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
                color: Colors.white,
              ),
              child: 
                Row( 
                  children: [
                    const SizedBox(width: 10.0),
                      Text( //제목 출력 칸
                        title,
                      ),
                  ]
                )
            ),
            const SizedBox(height: 20.0), //여백
            Expanded(
              child:
                Container( //링크 이동 버튼과 내용 출력 칸을 담을 컨테이너
                  decoration: BoxDecoration( 
                    borderRadius: BorderRadius.circular(9.0),
                    color: Colors.white
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 12.0), //여백
                      Container( //sizedBox와 버튼 넣을 컨테이너
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        color: Colors.white
                        ),
                        child : Row(
                          children: [
                            const SizedBox(width:12.0), //버튼 왼쪽 여백
                            Expanded( child: 
                              TextButton( //링크 이동 버튼
                                onPressed: () {
                                  if(link!=''){launchUrl(Uri.parse(link));}
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 4, 0, 113),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                ),
                                ),
                                child: const Text(
                                  "영상 보기",
                                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                                )
                              ),
                            ),
                            const SizedBox(width:12.0), //버튼 오른쪽 여백
                          ]
                        )
                      ),
                      const SizedBox(height: 10.0),
                      Row( 
                        children : [
                        const SizedBox(width:12.0), //내용 왼쪽 공백
                        Expanded(child: Text( //내용 출력 칸
                          content,
                          textAlign: TextAlign.start,)
                        ),
                        const SizedBox(width:12.0), //내용 오른쪽 공백
                        ]
                      )
                      ],   
                  )
                )
            ),
            const SizedBox(height: 72.0), //아래 여백
          ]
        )
        )
      );
  }
}
