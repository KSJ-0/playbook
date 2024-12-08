import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playbook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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

  void initState() {
    super.initState();
    setState(() {
      _selectedTeam = _teams[0];
    });
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
                  child: DropdownButton(
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
        //     Container(
        //       color : const Color.fromARGB(255, 2, 0, 98),
        //       padding: EdgeInsets.symmetric(vertical: 20.0), 
        //       child :
        //     Row( //수평 배열
        //     children: <Widget>[
        //       // Container(
        //       //   color: const Color.fromARGB(255, 255, 255, 255),
        //       //   padding: EdgeInsets.symmetric(horizontal: 10.0),
        //       //   child :
        //         Spacer(), //오른쪽 끝으로
        //         Container(
        //           padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(12.0)
        //           ),
        //           child: DropdownButton(
        //             dropdownColor: Colors.white,
        //             value: _selectedTeam,
        //             items: _teams.map((e) => DropdownMenuItem(
        //                   value: e,
        //                   child: Text(e),
        //                 ))
        //             .toList(),
        //             onChanged: (value) {
        //               setState(() {
        //                 _selectedTeam = value!;
        //               });
        //             }
        //           ),
        //         )
        //     // )
        //     ],
        //     ),
        //     ),
            SizedBox(height: 22.0),
            Row(
              children: [
                Image.asset(
                'assets/t1.jpg',
                width: MediaQuery.of(context).size.width - 32,
                height: (MediaQuery.of(context).size.width - 32) * 0.5625
                ),
              ] 
            ),
            SizedBox(height: 22.0),
            Expanded(
              child: ListView(
                children: List.generate(5, (number) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 11.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("   VICTORY🏆", style: TextStyle(fontSize: 17.0),),
                        SizedBox(height: 5.0),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 32,
                            child: Text(
                              "Title",
                              style: TextStyle(color: Colors.black, fontSize: 25.0),
                            )
                          )  
                        )
                      ]
                    )  
                    );
                }),
              ) ,
            ),
            ]
        ),    
      )
    );
  }
}
