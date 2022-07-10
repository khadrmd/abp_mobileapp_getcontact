import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_contact/api/contact.dart';
import 'package:get_contact/api/utils/get_initials.dart';
import 'package:get_contact/home_page.dart';
import 'package:get_contact/models/detail_contact.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactDetail extends StatefulWidget {
  final String id;

  const ContactDetail({Key? key, required this.id}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ContactDetail> {
  late Future<DetailContact> futureDetailContact = [] as Future<DetailContact>;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchContactProfile();
  }

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

  fetchContactProfile() {
    setState(() {
      futureDetailContact = ContactService.getProfile(widget.id);
    });
    futureDetailContact.then(
      (value) => {
        setState(() {
          _nameController.text = value.data!.user!.data!.name ?? "";
          _phoneController.text = value.data!.user!.data!.phone ?? "";
        })
      },
    );
  }

  deleteContact() async {
    try {
      Navigator.pop(context);
      await ContactService.deleteContact(widget.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleted')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = OutlinedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = OutlinedButton(
      child: const Text("Confirm"),
      onPressed: () {
        deleteContact();
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm Remove"),
      content: const Text(
          "Are you sure to delete this contact? this can't be undone!"),
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
          borderSide: BorderSide(
            color: Color(0xff22824b),
          ),
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
          borderSide: BorderSide(color: Color(0xff22824b)),
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
      child: const Text("Save"),
      onPressed: () async {
        ContactService.update(
            widget.id, _nameController.text, _phoneController.text);
        await fetchContactProfile();
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
            const SizedBox(
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
          colors: [
            Color(0xff22824b),
            Color(0xff6bac4c),
          ],
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
                      colors: [
                        Color(0xff6bac4c),
                        Color(0xff22824b),
                      ]),
                ),
                padding: const EdgeInsets.all(10),
                height: 80,
                child: FutureBuilder<DetailContact>(
                  future: futureDetailContact,
                  builder: (context, snapshots) {
                    if (snapshots.hasData) {
                      return Row(
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
                                getInitials(
                                  snapshots.data!.data!.user!.data!.name ?? "",
                                ),
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
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
                                  snapshots.data!.data!.user!.data!.name ?? "",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 23,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  snapshots.data!.data!.user!.data!.phone ?? "",
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
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder<DetailContact>(
                  future: futureDetailContact,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Aliases> aliases =
                          snapshot.data!.data!.aliases ?? [];

                      return ListView.builder(
                        itemCount: aliases.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            child: Text(
                              "# ${aliases[index].name}",
                              style: GoogleFonts.aBeeZee(fontSize: 20),
                            ),
                          );
                        },
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 15, right: 15),
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () => {showAlertDialog(context)},
                  child: const Icon(Icons.delete),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
