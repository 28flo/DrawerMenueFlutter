import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

Color hintergrundfarbe = Colors.white;
Color textfarbe = Colors.black;
String username = "";
ImageProvider? profilbild = NetworkImage(
    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png');
TextEditingController _textController = TextEditingController();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Sport',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  void bildmodus(modus) {
    if (modus == 1) {
      profilbild = NetworkImage(
          'https://file.hstatic.net/1000398692/article/et-co-xa-co-01-0-0-0-0-1530461344_e2d6159ebd7647639588ada97f83dcaf_b88ac1ed0251411694d9514e27b41313.jpg');
    }
    if (modus == 2) {
      profilbild =
          NetworkImage('https://pbs.twimg.com/media/FNcO0MmXoAY903L.jpg');
    }
    if (modus == 3) {
      profilbild = NetworkImage(
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png');
    }
    notifyListeners();
  }

  void farbmodus(modus) {
    if (modus == "hell") {
      hintergrundfarbe = Colors.white;
      textfarbe = Colors.black;
    }
    if (modus == "dunkel") {
      hintergrundfarbe = Colors.grey;
      textfarbe = Colors.white;
    }
    notifyListeners();
  }

  void setName(name) {
    username = name;
    notifyListeners();
  }

  void setimage() async {
    File? image;

    Future pickImage() async {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      image = File(pickedImage.path);
      profilbild = FileImage(image!);
      notifyListeners();
    }

    // Aufruf der pickImage()-Methode mit await
    await pickImage();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
        backgroundColor: hintergrundfarbe,
        drawer: NavigationDrawer(backgroundColor: hintergrundfarbe, children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Column(children: [
              Text(
                "Hallo " + username + "!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text("Profil bearbeiten"),
                            content: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      appState.bildmodus(1);
                                      Navigator.pop(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.brown,
                                      backgroundImage: NetworkImage(
                                          'https://file.hstatic.net/1000398692/article/et-co-xa-co-01-0-0-0-0-1530461344_e2d6159ebd7647639588ada97f83dcaf_b88ac1ed0251411694d9514e27b41313.jpg'),
                                      radius: 40.0,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      appState.bildmodus(2);
                                      Navigator.pop(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://pbs.twimg.com/media/FNcO0MmXoAY903L.jpg'),
                                      radius: 40.0,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          appState.setimage();
                                        },
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          size: 90,
                                        )),
                                    InkWell(
                                        onTap: () {
                                          appState.bildmodus(3);
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.delete_outline_rounded,
                                          size: 90,
                                        ))
                                  ]),
                              Divider(),
                              TextField(
                                controller: _textController,
                                onChanged: (value) {},
                                maxLength: 10,
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Benutzername",
                                    fillColor: Colors.blue.shade100,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    )),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  appState.setName(_textController.text);
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.pinkAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 15.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Speichern',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ]));
                      });
                },
                child: CircleAvatar(
                  backgroundImage: profilbild,
                  radius: 40.0,
                ),
              )
            ]),
          ),
          ListTile(
            textColor: textfarbe,
            iconColor: textfarbe,
            leading: Icon(Icons.local_drink),
            title: Text('Wassertracker'),
            onTap: () {},
          ),
          ListTile(
            textColor: textfarbe,
            iconColor: textfarbe,
            leading: Icon(Icons.run_circle_outlined),
            title: Text('Meine Läufe'),
            onTap: () {},
          ),
          ListTile(
            textColor: textfarbe,
            iconColor: textfarbe,
            leading: Icon(Icons.food_bank_outlined),
            title: Text('Calorientracker'),
            onTap: () {},
          ),
          Divider(
            color: textfarbe,
          ),
          ListTile(
              textColor: textfarbe,
              iconColor: textfarbe,
              leading: Icon(Icons.settings),
              title: Text('Einstellungen'),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: ((builder) => BottomSheet(context)));
              }),
        ]),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Cooler Name"),
          backgroundColor: Colors.grey,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 183, 183, 183),
                      Color.fromARGB(255, 134, 134, 134)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Wasserbedarf"),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        Icons.local_drink,
                        size: 70,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text("noch:"),
                        ],
                      ),
                      Text(
                        "1000",
                        style: TextStyle(fontSize: 70),
                      ),
                      Text("ml")
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 183, 183, 183),
                      Color.fromARGB(255, 134, 134, 134)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Meine Läufe"),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        Icons.run_circle_outlined,
                        size: 70,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text("schon:"),
                        ],
                      ),
                      Text(
                        "56",
                        style: TextStyle(fontSize: 70),
                      ),
                      Text("km")
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 183, 183, 183),
                      Color.fromARGB(255, 134, 134, 134)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Kalorienbedarf"),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        Icons.food_bank_outlined,
                        size: 70,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text("schon:"),
                        ],
                      ),
                      Text(
                        "1532",
                        style: TextStyle(fontSize: 70),
                      ),
                      Text("kcal")
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget BottomSheet(BuildContext context) {
    var appState = Provider.of<MyAppState>(context, listen: false);
    return Container(
      height: 100.0,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Einstellungen",
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Icon(
                  Icons.light_mode_rounded,
                  size: 70,
                ),
                onTap: () {
                  appState.farbmodus("hell");
                },
              ),
              InkWell(
                child: Icon(
                  Icons.dark_mode_rounded,
                  size: 70,
                ),
                onTap: () {
                  appState.farbmodus("dunkel");
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
