import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_vault_app/data/FirebaseService/firestore_service.dart';
import 'package:password_vault_app/presentation/update_password_data_page/update_password_data_page.dart';

class HomePageTile extends StatefulWidget {
  final String username;
  final String website;
  final String password;
  final Timestamp timestamp;
  final String docID;
  const HomePageTile(
      {super.key,
      required this.username,
      required this.website,
      required this.password,
      required this.timestamp,
      required this.docID});

  @override
  State<HomePageTile> createState() => _HomePageTileState();
}

class _HomePageTileState extends State<HomePageTile> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xff8c8c8c),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.website,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SelectableText(
                    widget.username,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      tapped
                          ? SelectableText(
                              widget.password,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            )
                          : Text(
                              "*" * widget.password.length,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              tapped = !tapped;
                            });
                          },
                          child: tapped
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.grey[200],
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey[200],
                                )),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          final password = ClipboardData(text: widget.password);
                          Clipboard.setData(password);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Password copied to clipboard',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      )
                                    ],
                                  )));
                        },
                        child: Icon(
                          Icons.copy,
                          color: Colors.grey[200],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Last updated on: ${widget.timestamp.toDate()}',
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
              const Spacer(),
              PopupMenuButton(
                style: const ButtonStyle(
                  iconColor: WidgetStatePropertyAll(Colors.white),
                  iconSize: WidgetStatePropertyAll(30),
                ),
                color: Colors.white54,
                itemBuilder: (context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdatePasswordPage(
                            username: widget.username,
                            website: widget.website,
                            password: widget.password,
                            timestamp: widget.timestamp,
                            docID: widget.docID,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                    value: "Edit",
                    child: const ListTile(
                      leading: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      title: Text(
                        "Edit",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      try {
                        FirestoreService().removeData(widget.docID);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Colors.green,
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Data removed successfully",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                )));
                      } on FirebaseException {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Colors.red,
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Something went wrong",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                )));
                      }
                    },
                    value: "Remove",
                    child: const ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      title: Text(
                        "Remove",
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*
GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatePasswordPage(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: 50,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(24)),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(24)),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),*/
