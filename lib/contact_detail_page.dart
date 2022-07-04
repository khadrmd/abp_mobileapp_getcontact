import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<ContactDetail> {
  showAlertDialog(BuildContext context) {
    Widget cancelButton = OutlinedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = OutlinedButton(
      child: Text("Confirm"),
      onPressed: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Remove"),
      content:
          Text("Are you sure to delete this contact? this can't be undone!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showEditPanel(BuildContext context) {
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
      child: Text("Save"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Edit Contact"),
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
                          onPressed: () => {showEditPanel(context)},
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
                Container(
                  padding: EdgeInsets.only(bottom: 15, right: 15),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () => {showAlertDialog(context)},
                    child: Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
