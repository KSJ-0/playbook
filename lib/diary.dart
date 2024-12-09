import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key, required this.title});

  final String title;

  @override
  State<DiaryPage> createState() => _MyDiaryPageState();
}

class _MyDiaryPageState extends State<DiaryPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  String docId = '';
  String link = '';

  void initState() {
    super.initState();
    setState(() {
    });
  }

  Future<void> uploadData() async {
    try { //일기 제목, 내용, 첨부 링크 저장
      DocumentReference doc = await FirebaseFirestore.instance.collection('diary').add({
        'title': _titleController.text,
        'content': _contentController.text,
        'createdAt': FieldValue.serverTimestamp(),
        'link': link,
      });
      docId = doc.id;
    } catch(e) {
    print("저장 실패: $e");

    }
    try { //생성한 일기 문서 ID 저장
      await FirebaseFirestore.instance.collection('user').doc('1').update({
        'diary_array': FieldValue.arrayUnion([docId])
      });
    } catch(e) {
    print("저장 실패: $e");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 0, 113),
        leading : 
          IconButton( //저장 버튼
            onPressed: () {
              uploadData();
            },
            icon : const Icon(Icons.save),
            color : Colors.white
          ),
        actions: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical:8.0),
          child:
            Container( //검색 창 컨테이너
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white, 
              ),
              child : TextField( //검색창
                controller: _searchController,
                decoration: InputDecoration(
                hintText: "Search",
                hintStyle: 
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                prefixIcon: const Icon(Icons.search), 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 2.0)
                ),
              )
            )
          )
        ],
      ),
    body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: 
        Column( //수직 배열
          children: <Widget>[
            const SizedBox(height: 20.0),
            Container( //제목 칸과 링크 이동 버튼을 담을 컨테이너
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
                color: Colors.white,
              ),
              child: 
                Row( 
                  children: [
                    const SizedBox(width: 10.0),
                    Expanded( 
                      child:
                      Container( 
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.0)
                        ),
                        child: 
                        TextField( //제목 입력 칸
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                          ),
                      ))
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      child: //링크 첨부 버튼
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet<void> (
                              context : context,
                              builder : (BuildContext context) {
                                return Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _linkController,
                                        decoration: InputDecoration(
                                          hintText: "링크를 입력하세요",
                                          hintStyle: TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                      ),
                                      const SizedBox(height: 12.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center, 
                                        children: [
                                          const SizedBox(width: 12.0,),
                                          Container(
                                            width: 100.0, 
                                            child :
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: const Color.fromARGB(255, 4, 0, 113),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(9.0),
                                                ),
                                              ),
                                              onPressed: () {
                                              link = _linkController.text;
                                              }, 
                                              child: 
                                                const Text(
                                                  "저장",
                                                  style: TextStyle(color: Colors.white,),)
                                            )
                                          ),
                                          const SizedBox(width: 12.0,),
                                        ]
                                      ),
                                      ] 
                                  
                                  )
                                );
                              }
                            );  
                          },                         
                          icon: const Icon(Icons.link))
                    )
                  ]
                ),
            ), 
            const SizedBox(height: 20.0), //여백
            Expanded(
              child:
                Container( //링크 이동 버튼과 내용 입력 칸을 담을 컨테이너
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
                              TextButton( //버튼
                                onPressed: () {},
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
                      Expanded( child : 
                        TextFormField( //내용 칸
                          controller: _contentController,
                          maxLines: 17,
                          minLines: null,
                          decoration: const InputDecoration(
                            hintText: " Content",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      )
                      ],   
                  )
                )
            ),
            const SizedBox(height: 72.0), //아래 여백
          ],
        ),
      )
      );
    
  }
}
