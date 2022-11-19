import 'package:flutter/material.dart';
import 'package:instagram_clone/style.dart' as appBarStyle;
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  var data = [];

  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));

    result.statusCode;

    var result2 = jsonDecode(result.body);
    setState(() {
      data = result2;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

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
      body: [content( data : data), Text('샵페이지')][tab],
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
  const content({Key? key, this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      return ListView.builder(
          itemCount: 3,
          itemBuilder: (context, i) {
            return Column(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(data[i]['image']),
                      Text(data[i]['content']),
                      Text(data[i]['user']),
                      Text(data[i]['date'])
                    ],
                  ),
                )
              ],

            );
          }
      );
    } else {
      return Text('로딩중');
    }
  }
}