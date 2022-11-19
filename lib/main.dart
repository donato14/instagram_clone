import 'package:flutter/material.dart';
import 'package:instagram_clone/style.dart' as appBarStyle;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';

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

class content extends StatefulWidget {
  content({Key? key, this.data}) : super(key: key);
  var data;

  @override
  State<content> createState() => _contentState();
}

class _contentState extends State<content> {

  var scroll = ScrollController();


  getMore() async{
    var moreData = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));

    moreData.statusCode;

    var result2 = jsonDecode(moreData.body);
    setState(() {
      widget.data = [...widget.data, result2];
      print(widget.data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scroll.addListener(() {
      print(scroll.position.pixels);
      if(scroll.position.pixels == scroll.position.maxScrollExtent){
        getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return ListView.builder(
          itemCount: widget.data.length,
          controller: scroll,
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
                      Image.network(widget.data[i]['image']),
                      Text('좋아요 ${widget.data[i]['likes']}'),
                      Text(widget.data[i]['user']),
                      Text(widget.data[i]['date'])
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