import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_contact/api/contact.dart';
import 'package:get_contact/api/users.dart';
import 'package:get_contact/api/utils/get_initials.dart';
import 'package:get_contact/login_page.dart';
import 'package:get_contact/models/contact.dart';
import 'package:get_contact/models/user.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_contact/contact_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late Future<User> futureProfile = [] as Future<User>;

  String? _validateName(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  String? _validatePhone(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Phone is required";
    }
    if (!RegExp(r"^(^08)(\d{3,4}-?){2}\d{3,4}$").hasMatch(txt)) {
      return "Not a valid phone number";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  fetchProfile() {
    setState(() {
      futureProfile = UserService.getProfile();
    });
  }

  FutureOr onGoBack(dynamic value) {
    fetchProfile();
  }

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

        await ContactService.addContact(
            _nameController.text, _phoneController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added new contact')),
        );

        Navigator.pop(context);
      } catch (err) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString())),
        );
      }
    }
  }

  showAddPanel(BuildContext context) {
    Widget nameField = TextFormField(
      controller: _nameController,
      validator: _validateName,
      style: GoogleFonts.aBeeZee(fontSize: 20),
      decoration: const InputDecoration(
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff22824b),
          ),
        ),
        fillColor: Colors.white,
        hintText: "Name",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff22824b)),
        ),
      ),
    );

    Widget phoneField = TextFormField(
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
        hintText: "Phone Number",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff22824b)),
        ),
      ),
    );

    Widget cancelButton = OutlinedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget saveButton = OutlinedButton(
      child: const Text("Add"),
      onPressed: () async {
        _handleSubmit();
        await fetchProfile();
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Add Contact"),
      content: Form(
        key: _formKey,
        child: Container(
          height: 140,
          width: 400,
          child: Column(
            children: [
              nameField,
              const SizedBox(
                height: 10,
              ),
              phoneField
            ],
          ),
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
    void _handleClick(String value) async {
      switch (value) {
        case 'Logout':
          await UserService.logout();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logout Successful')),
          );
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );

          break;
      }
    }

    return Scaffold(
      appBar: NewGradientAppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        centerTitle: true,
        title: Text(
          'GET CONTACT',
          style: GoogleFonts.righteous(fontSize: 27),
        ),
        gradient: const LinearGradient(
            colors: [Color(0xff22824b), Color(0xff6bac4c)]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff6bac4c),
        onPressed: () => {showAddPanel(context)},
        child: const Icon(
          Icons.add_rounded,
          size: 50,
        ),
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
                  child: FutureBuilder<User>(
                    future: futureProfile,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
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
                                child: Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.name ?? "-",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 23,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.phone ?? "-",
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 18,
                                          color: Colors.grey[350],
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.email ?? "-",
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 15,
                                          color: Colors.grey[350],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )),
              Expanded(
                child: Container(
                  child: FutureBuilder<User>(
                    future: futureProfile,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Contacts> contacts = snapshot.data!.contacts ?? [];

                        return ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 70,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white),
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContactDetail(
                                        id: contacts[index].id ?? "",
                                      ),
                                    ),
                                  ).then(onGoBack)
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: const Color(0xff6bac4c),
                                      child: Text(
                                        getInitials(contacts[index].name ?? ""),
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      contacts[index].name ?? "",
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.black87, fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
