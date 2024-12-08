import 'package:flutter/material.dart';
import 'package:playbook/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 5, 2, 102),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: 
        Column( //수직 배열
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Playbook",
              style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.white) 
            ),
            const SizedBox(height: 45.0),
            Row(children: [
              const SizedBox(width: 60.0),
              Expanded(child: 
                TextField(
                  decoration: InputDecoration(
                    hintText: " ID",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                  ),
                  ),
              ),  
              const SizedBox(width: 60.0),
            ],
            ),
            const SizedBox(height: 25.0),
            Row(children: [
              const SizedBox(width: 60.0),
              Expanded(child: 
                TextField(
                  decoration: InputDecoration(
                    hintText: " Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                  ),
                  ),
              ),  
              const SizedBox(width: 60.0),
            ],
            ),
            const SizedBox(height: 45.0),
            Container(
              width: 80, // 원하는 너비
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.0)
              ),
              child : TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context, '/home'
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                  )
              )
            ),
          ]
        ),    
      )
    );
  }
}
