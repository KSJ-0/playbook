import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:playbook/diary.dart';
import 'package:playbook/diary_read.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  //드롭다운 메뉴 옵션
  final _teams = ['T1','한화생명','젠지','KT','OK저축은행','농심','BNK','광동','DRX','DK','KIA타이거즈              ','삼성라이온즈','엘지트윈스','엔씨다이노스','KT위즈','한화이글스','SSG랜더스','두산베어스','롯데자이언츠','키움히어로즈'];
  String? _selectedTeam;
  var data;
  String _diaryId = '';

  void initState() {
    super.initState();
    setState(() {
      _selectedTeam = _teams[0];
    });
  }

  getUserData() async {
    var result = await FirebaseFirestore.instance.collection('user').doc('1').get();
    return result.data();
  }

  getDiary(String docId) async {
    var result = await FirebaseFirestore.instance.collection('diary').doc(docId).get();
    return result.data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 0, 113),
        actions: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical:10.0),
          child:Row( //수평 배열
            children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                  child: DropdownButton( //팀 선택 버튼
                    dropdownColor: Colors.white,
                    value: _selectedTeam,
                    items: _teams.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTeam = value!;
                      });
                    }
                  ),
                )
            ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: 
        Column( //수직 배열
          children: <Widget>[
            const SizedBox(height: 22.0),
            Row(
              children: [
                Image.asset(
                'assets/t1.jpg',
                width: MediaQuery.of(context).size.width - 32,
                height: (MediaQuery.of(context).size.width - 32) * 0.5625
                ),
              ] 
            ),
            const SizedBox(height: 22.0),
            Stack(children: [ //리스트 위에 버튼을 배치하기 위한 스택
              Container( //일기 리스트를 담기 위한 컨테이너
                height: MediaQuery.of(context).size.height - 400,
                child: StreamBuilder<QuerySnapshot>( //저장되어 있는 데이터 읽어오기
                  stream: FirebaseFirestore.instance.collection('diary').orderBy('createdAt').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.data == null) {
                      return Text('데이터가 없습니다.');
                    }
                    var docs = snapshot.data!.docs;
                    if(docs.isNotEmpty) { //데이터 있는 경우
                    return ListView.builder( //일기 리스트
                      itemCount: (docs.length <5) ? docs.length : 5, //최대 5개 노출
                      itemBuilder: (context, index) {
                        data = docs[index];
                        var diaryId = data.id;
                        return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 11.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ //승패 여부
                          Text(
                            data['result'] == '승리' ? 'VICTORY🏆' : 'DEFEAT😨',
                            style: const TextStyle(fontSize: 17.0),
                          ),
                          const SizedBox(height: 5.0),
                          TextButton( //목록
                            onPressed: () {     
                              _diaryId = data.id;             
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DiaryReadPage(diaryId: diaryId)));
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 32,
                              child: Text(
                                data["title"] ?? "제목 없음", //제목 읽어서 출력
                                style: TextStyle(color: Colors.black, fontSize: 25.0),
                              )
                            )  
                          )
                        ]
                      )  
                      );
                    }
                    );
                    }
                    else {
                    return Column( //데이터 없는 경우
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ //승패 여부
                          const Text("   VICTORY🏆", style: TextStyle(fontSize: 17.0),),
                          const SizedBox(height: 5.0),
                          TextButton( //목록
                            onPressed: () {                  
                              
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 32,
                              child: const Text(
                                "Title",
                                style: TextStyle(color: Colors.black, fontSize: 25.0),
                              )
                            )  
                          )
                        ]
                      );
                      }
                    }
                  )
              ),    
              Positioned( //리스트 위에 버튼 배치
                bottom: 10.0, 
                right: 10.0,  
                child: Container( //버튼 담을 컨테이너
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: const Color.fromARGB(255, 4, 0, 113),
                  ),
                  child: TextButton( //새 일기 작성 버튼
                    child: const Text(
                      "+",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/diary");
                    },                  
                  ),
                ),
              ),
            ],)
            ]
        ),    
      )
    );
  }
}
