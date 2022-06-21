//Khaidir Mauladan - 1301192327
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: new App());
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Get Contact'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Align(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.deepPurple[400]),
                  padding: EdgeInsets.all(10),
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.person,
                          size: 55,
                          color: Colors.deepPurple[100],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kwasonk Mauladan (You)",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[200],
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple[200],
                              ),
                              child: Text("+6281990921517")),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    children: [
                      Container(
                        height: 50,
                        child: Text("Contact 1"),
                      ),
                      Container(
                        height: 50,
                        child: Text("Contact 2"),
                        
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
