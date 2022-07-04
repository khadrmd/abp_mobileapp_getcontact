import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_contact/contact_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  showAddPanel(BuildContext context) {
    Widget nameField = TextField(
      style: GoogleFonts.aBeeZee(fontSize: 20),
      decoration: const InputDecoration(
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff22824b))),
          fillColor: Colors.white,
          hintText: "Name",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff22824b)),
          )),
    );

    Widget phoneField = TextField(
      keyboardType: TextInputType.phone,
      style: GoogleFonts.aBeeZee(fontSize: 20),
      decoration: const InputDecoration(
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff22824b))),
          fillColor: Colors.white,
          hintText: "Phone Number",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff22824b)),
          )),
    );

    Widget cancelButton = OutlinedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget saveButton = OutlinedButton(
      child: Text("Add"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Add Contact"),
      content: Container(
        height: 140,
        width: 400,
        child: Column(
          children: [
            nameField,
            SizedBox(
              height: 10,
            ),
            phoneField
          ],
        ),
      ),
      actions: [
        cancelButton,
        saveButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
                  height: 110,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[700],
                        ),
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.green[100],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kwasonk Mauladan",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "+6281990921517",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                                color: Colors.grey[350],
                              ),
                            ),
                            Text(
                              "khaidir@gmail.com",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 15,
                                color: Colors.grey[350],
                              ),
                            ),
                          ],
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
                      SizedBox(
                        height: 70,
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.white),
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ContactDetail()))
                                },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(0xff6bac4c),
                                  child: Text(
                                    "AH",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Asep Hudson",
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.black87, fontSize: 18),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        height: 70,
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.white),
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ContactDetail()))
                                },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(0xff6bac4c),
                                  child: Text(
                                    "MJ",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Michael Junaedi",
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.black87, fontSize: 18),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 15, right: 15),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xff6bac4c),
                    onPressed: () => {showAddPanel(context)},
                    child: Icon(
                      Icons.add_rounded,
                      size: 50,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
