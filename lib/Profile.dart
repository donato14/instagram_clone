import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.watch<Store2>().name2)),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.account_circle),
                  Text('팔로워 ${context.watch<Store1>().follower}명'),
                  ElevatedButton(onPressed: (){
                    context.read<Store1>().changeFollower();
                  }, child: Text('팔로우')),
                  ElevatedButton(onPressed: (){
                    context.read<Store1>().getData();
                  }, child: Text('사진가져오기'))
                ],
              ),
            ),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  (c,i) => Image.network(context.watch<Store1>().profileImage[i]),
                childCount: context.watch<Store1>().profileImage.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          ),
        ],
      ),
    );
  }
}
