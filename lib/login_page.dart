import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_contact/home_page.dart';
import 'package:get_contact/register_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xff22824b), Color(0xff6bac4c), Colors.white]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "GET CONTACT",
              style: GoogleFonts.righteous(fontSize: 40, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: 300,
              child: TextField(
                keyboardType: TextInputType.phone,
                style: GoogleFonts.aBeeZee(fontSize: 20),
                decoration: const InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff22824b))),
                    fillColor: Colors.white,
                    hintText: "Enter Phone Number",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff22824b)),
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: 300,
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                style: GoogleFonts.aBeeZee(fontSize: 20),
                decoration: const InputDecoration(
                    isDense: true,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff22824b))),
                    fillColor: Colors.white,
                    hintText: "Enter Password",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff22824b)),
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(Colors.green[100]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    fixedSize: MaterialStateProperty.all(const Size(200, 40))),
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()))
                    },
                child: Text(
                  "Login",
                  style: GoogleFonts.aBeeZee(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff22824b)),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: GoogleFonts.aBeeZee(),
                ),
                TextButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()))
                        },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.aBeeZee(color: Colors.white),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
