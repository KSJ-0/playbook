import 'package:flutter/material.dart';


class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key, required this.title});

  final String title;

  @override
  State<DiaryPage> createState() => _MyDiaryPageState();
}

class _MyDiaryPageState extends State<DiaryPage> {

  void initState() {
    super.initState();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 0, 113),
        leading : 
          IconButton( //저장 버튼
            onPressed: () {},
            icon : const Icon(Icons.save),
            color : Colors.white
          ),
        actions: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical:8.0),
          child:
            Container( //검색 창 컨테이너
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white, 
              ),
              child : TextField( //검색창
                decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search), 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                fillColor: Colors.white,
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
                        const TextField( //제목 입력 칸
                          decoration: InputDecoration(
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
                        IconButton(onPressed: () {}, icon: const Icon(Icons.link))
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
                      TextFormField( //내용 칸
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
