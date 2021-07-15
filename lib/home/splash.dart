import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget{
  Widget build(BuildContext context){
    return Material(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: Image.asset('assets/images/private_gallery_icon.png'),
            ),
            Divider(color: Colors.transparent,),
            CircularProgressIndicator(),
            Divider(color: Colors.transparent,),
            Text('Loading')
          ],
        ),
      ),
    );
  }
}