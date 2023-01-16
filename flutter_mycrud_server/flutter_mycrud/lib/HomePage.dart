import 'package:flutter/material.dart';
import 'main.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.only(top: 200),
                    child: TextButton(
                      onPressed:() {
                        Navigator.pushNamed(context, '/add');
                      }, child: Text('Add Order',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.only(top: 100),
                    child: TextButton(
                      onPressed:() {
                        Navigator.pushNamed(context, '/view');
                      }, child: Text('View and stuff',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    ),
                  ),
                  Container()

                ]
            )


        )
    );
  }
}