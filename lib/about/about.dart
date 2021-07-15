
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('About App'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(child: Column(
              children: [
                SizedBox(
                  width: 150,
                  child:Image.asset('assets/images/private_gallery_icon.png'),
                ),
                Text('Private Gallery', style: TextStyle(fontSize: 30),)
              ],
            ),),
            Text('This app was built by Kirubel Adamu'),
            Text('Email: kirub33@yahoo.com')
          ],
        ),
      
      ),
    );
  }
}