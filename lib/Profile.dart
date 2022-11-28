import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.watch<Store1>().name)),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){

            context.read<Store1>().changeName();
          }, child: Text('버튼')),
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.account_circle),
                Text('팔로워 ${context.watch<Store1>().follower}'),
                ElevatedButton(onPressed: (){
                  context.read<Store1>().changeFollower();
                }, child: Text('팔로우'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
