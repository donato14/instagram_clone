import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/notification.dart';
import 'package:instagram_clone/style.dart' as appBarStyle;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:instagram_clone/upload.dart' as Uploda;
import 'package:instagram_clone/Profile.dart' as Profile;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initalizeApp(
    option: DefaultFirebase
  )

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => Store1()),
        ChangeNotifierProvider(create: (c) => Store2())
      ],
      child: MaterialApp(
        theme: appBarStyle.theme,
        //라우트 사용시
        // initialRoute: '/',
        // routes: {
        //   '/' : (c) =>Text('첫번째 페이지'),
        //   '/detail' : (c) => Text('둘째 페이지')
        // },
        home: MyApp()
      ),
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
  var userImage;
  var userContent;

  saveData() async{
    var storage = await SharedPreferences.getInstance(); //저장공간 오픈
    storage.setString('name', 'john');

    // storage.remove('name');
    var map = {'age' : 20};
    storage.setString('map', jsonEncode(map));
    var result2 = storage.getString('map') ?? 'NullCheck';
    print(jsonDecode(result2)['age']);

    var result = storage.getString('name');
    print(result);
  }

  addMyData(){
    var myData = {
      'id' : data.length,
      'image' : userImage,
      'likes' : 5,
      'date': 'July 25',
      'content' : userContent,
      'liked' : false,
      'user' : 'John Kim'
    };
    setState(() {
      data.insert(0, myData);
    });
  }

  setUserContent(a){
    setState(() {
      userContent = a;
    });
  }

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
    initNotification();
    saveData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Text('+'), onPressed: (){
        showNotification();
      },),
      appBar: AppBar(
        title: Text('Instagram', textAlign: TextAlign.left,),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null){
                setState(() {
                  userImage = File(image.path);
                });
              }

              Navigator.push(context,
                MaterialPageRoute(builder: (c) => Uploda.Upload(userImage : userImage, setUserContent : setUserContent, addMyData : addMyData) )
              );
            },
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
      // print(scroll.position.pixels);
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
                      widget.data[i]['image'].runtimeType == String
                          ? Image.network(widget.data[i]['image'])
                          : Image.file(widget.data[i]['image']),

                      GestureDetector(
                        child: Text(widget.data[i]['user']),
                        onTap: (){
                          Navigator.push(context,
                            // MaterialPageRoute(builder: (c) => Profile.Profile())
                            CupertinoPageRoute(builder: (c) => Profile.Profile())
                            // PageRouteBuilder(
                            //   pageBuilder: (c, a1, a2) => Profile.Profile(),
                            //   transitionsBuilder: (c, a1, a2, child) =>
                            //     // FadeTransition(opacity: a1, child: child,),
                            //     SlideTransition(
                            //         position: Tween(
                            //           begin: Offset(-1.0, 0.0),
                            //           end: Offset(0.0, 0.0),
                            //         ).animate(a1),
                            //       child: child,
                            //     ),
                            //   transitionDuration: Duration(milliseconds: 500)
                            // )
                          );
                        },
                        // onDoubleTap: (){},
                      ),
                      Text('좋아요 ${widget.data[i]['likes']}'),
                      Text(widget.data[i]['date']),
                      Text(widget.data[i]['content']),
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

class Store1 extends ChangeNotifier {
  var name = 'john kim';
  var follower = 0;
  var clickCheck = 0;
  var profileImage = [];

  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2 = jsonDecode(result.body);

    profileImage = result2;
    notifyListeners();
  }


  changeName(){
    name = 'john park';
    notifyListeners();
  }
  changeFollower(){
    if(clickCheck == 0) {
      follower++;
      clickCheck++;
      notifyListeners();
    }
    else if (clickCheck == 1){
      follower--;
      clickCheck--;
      notifyListeners();
    }
  }
}

class Store2 extends ChangeNotifier {
  // 스토어를 두개 만들었을시
  var name2 = 'john doe';
}