import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_contact/api/users.dart';
import 'package:get_contact/home_page.dart';
import 'package:get_contact/register_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validatePhone(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Phone is required";
    }
    if (!RegExp(r"^(^08)(\d{3,4}-?){2}\d{3,4}$").hasMatch(txt)) {
      return "Not a valid phone number";
    }
    return null;
  }

  String? _validatePassword(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Password is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    void _handleSubmit() async {
      if (_formKey.currentState!.validate()) {
        try {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            ),
          );

          await UserService.login(
              _phoneController.text, _passwordController.text);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful')),
          );

          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false,
          );
        } catch (err) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.toString())),
          );
        }
      }
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
                height: 90,
                width: 300,
                child: TextFormField(
                  controller: _phoneController,
                  validator: _validatePhone,
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.aBeeZee(fontSize: 20),
                  decoration: const InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff22824b),
                      ),
                    ),
                    fillColor: Colors.white,
                    hintText: "Enter Phone Number",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff22824b),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 90,
                width: 300,
                child: TextFormField(
                  controller: _passwordController,
                  validator: _validatePassword,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: GoogleFonts.aBeeZee(fontSize: 20),
                  decoration: const InputDecoration(
                      isDense: true,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff22824b),
                        ),
                      ),
                      fillColor: Colors.white,
                      hintText: "Enter Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff22824b),
                        ),
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
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all(
                    const Size(200, 40),
                  ),
                ),
                onPressed: _handleSubmit,
                child: Text(
                  "Login",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff22824b),
                  ),
                ),
              ),
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
                          builder: (context) => RegisterPage(),
                        ),
                      )
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.aBeeZee(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
