import 'package:flutter/material.dart';
import 'package:scanner_app/widgets/Create.dart';
import 'widgets/scanner.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Scanner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.scanner),
                  ),
                  Tab(
                    icon: Icon(Icons.create),
                  )
                ],
              ),
              title: Text('Scanner App'),
            ),
            body: TabBarView(
              children:[
                Scanner(),
                Create()
              ],
            ),
          ),
        ));
  }
}
