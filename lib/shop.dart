import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  getData() async {
    try {
      var result = await firestore.collection('product').doc(
          'NF4wpcFxwlNpPAmVfGZE').get();

      print(result['name']);
      print(result['price']);
    } catch(e){
      print('에러났음');
    }

    await firestore.collection('product').add({'name' : '내복', 'price': 5000});
    // await firestore.collection('product').doc().delete({});
    // await firestore.collection('product').doc().update(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('샵페이지임!!'),
    );
  }
}
