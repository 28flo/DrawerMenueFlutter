import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int zaehler = 0;

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
        title: 'Take me home',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  void counter() {
    zaehler++;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      drawer: NavigationDrawer(children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(children: [
            Text(
              'Hallo Flo!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
              radius: 40.0,
            ),
            SizedBox(height: 10),
            Text('email@adresse.com',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                )),
          ]),
        ),
        ListTile(
          leading: Icon(Icons.local_drink),
          title: Text('Ich trinke!'),
          onTap: () {
            appState.counter();
          },
        ),
        ListTile(
          leading: Icon(Icons.car_crash),
          title: Text('Ich bleibe nüchtern!'),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
      ]),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Test:" + zaehler.toString()),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Text("abc"),
      ),
    );
  }
}
