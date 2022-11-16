import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        iconTheme: IconThemeData( color: Colors.blue ),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          centerTitle: false,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
          actionsIconTheme: IconThemeData(color: Colors.black)
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.red)
        )
      ),
      home: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram', textAlign: TextAlign.left,),
        actions: [Icon(Icons.add_box_outlined)],
      ),
      body: Text('하이')
    );
  }
}

