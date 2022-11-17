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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;



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
      body: [content(), Text('샵페이지')][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: '홈',
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            label: '샵',
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag)
          )
        ],
      )
    );
  }
}

class content extends StatelessWidget {
  const content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, i) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Image.asset('/car2.png'),
              Text('좋아요 100',textAlign: TextAlign.right),
              Text('글쓴이'),
              Text('글내용')
            ],
          ),
        );
      }
    );
  }
}
