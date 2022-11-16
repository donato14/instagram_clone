import 'package:flutter/material.dart';
import 'package:instagram_clone/style.dart' as appBarStyle;

void main() {
  runApp(
    MaterialApp(
      theme: appBarStyle.theme,
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
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: (){},
            iconSize: 30,
          )
        ],
      ),
      body: Text('안녕', style: Theme.of(context).textTheme.bodyText2,),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home_outlined),
              Icon(Icons.shopping_bag_outlined)
            ],
          ),
        ),
      ),
    );
  }
}

