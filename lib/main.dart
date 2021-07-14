import 'package:flutter/material.dart';
import 'package:private_gallery/home/home.dart';
void main() {
  runApp(PrivateGallery());
}
class PrivateGallery extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Private Gallery",
      home: Home(),
    );
  }
}