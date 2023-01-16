import 'package:flutter/material.dart';
import 'package:flutter_mycrud/AddPage.dart';
import 'package:flutter_mycrud/EditPage.dart';
import 'package:flutter_mycrud/Repo/OrderRepository.dart';
import 'package:flutter_mycrud/db/OrderDatabase.dart';
import 'package:flutter_mycrud/locator.dart';
import 'package:flutter_mycrud/viewModels/HomeViewModel.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'ViewPage.dart';
// void main() {
//   setupLocator();
//   runApp(
//       const MyApp());
//
// }
void main() async{
  setupLocator();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>HomeViewModel(orderRepo: locator<OrderRepository>()))
    ],
    child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
      '/':(context)=>LoginDemo(),
      '/home':(context)=>HomePage(),
      '/add':(context)=>AddPage(),
      '/view':(context)=>ViewPage(),
      '/edit':(context)=>EditPage()
      },
    );
  }
}


class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final controlPassword=TextEditingController();
  final controlUsername=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controlUsername,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'username',
                    hintText: 'Enter username'),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: controlPassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'password',
                    hintText: 'Enter password'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/home',(Route<dynamic> route) => false);

                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}