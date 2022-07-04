import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<ContactDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
          centerTitle: true,
          title: Text(
            'GET CONTACT',
            style: GoogleFonts.righteous(fontSize: 27),
          ),
          gradient: const LinearGradient(
              colors: [Color(0xff22824b), Color(0xff6bac4c)]),
        ),
        body: Center(
          child: Align(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff6bac4c), Color(0xff22824b)]),
                  ),
                  padding: const EdgeInsets.all(10),
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[700],
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff22824b),
                          child: Text(
                            "AH",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Asep Hudson",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "+6281234567890",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                color: Colors.grey[350],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 50,
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () => {},
                          icon: const Icon(Icons.edit),
                          color: Colors.green[300],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)),
                        child: Text(
                          "# Alias 1",
                          style: GoogleFonts.aBeeZee(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)),
                        child: Text(
                          "# Alias 2",
                          style: GoogleFonts.aBeeZee(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
