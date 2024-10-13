import 'package:flutter/material.dart';
import 'package:password_vault_app/presentation/update_password_data_page/update_password_data_page.dart';

class HomePageTile extends StatefulWidget {
  final String name;
  const HomePageTile({super.key, required this.name});

  @override
  State<HomePageTile> createState() => _HomePageTileState();
}

class _HomePageTileState extends State<HomePageTile> {
  bool tapped = false;
  var selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xff8c8c8c),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      tapped
                          ? const SelectableText(
                              "Password shown",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          : Text(
                              "*" * 20,
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
                        onTap: () {},
                        child: Icon(
                          Icons.copy,
                          color: Colors.grey[200],
                        ),
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
              PopupMenuButton(
                style: const ButtonStyle(
                  iconColor: WidgetStatePropertyAll(Colors.white),
                  iconSize: WidgetStatePropertyAll(30),
                ),
                color: Colors.white54,
                initialValue: selectedItem,
                itemBuilder: (context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpdatePasswordPage(),
                          ));
                    },
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
                    value: "Edit",
                  ),
                  PopupMenuItem(
                    onTap: () {},
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
                    value: "Remove",
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
