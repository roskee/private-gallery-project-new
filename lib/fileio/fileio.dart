import 'package:flutter/material.dart';
import 'filedescriptors.dart';

class FileIO {
List<Image> _images = [];
List<MyVideo> _videos = [];
List<MyFile> _files = [];
FileIO(){
  _images =[
    Image.asset('assets/images/private_gallery_icon.png'),
    Image.asset('assets/images/private_gallery_icon.png'),
    Image.asset('assets/images/private_gallery_icon.png'),
    Image.asset('assets/images/private_gallery_icon.png'),
    Image.asset('assets/images/private_gallery_icon.png'),
    Image.asset('assets/images/private_gallery_icon.png'),
  ];
  _videos =[
    MyVideo("hi","hi","hi"),
    MyVideo("hi","hi","hi"),
    MyVideo("hi","hi","hi"),
    MyVideo("hi","hi","hi"),
    MyVideo("hi","hi","hi")
  ];
  _files =[
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
    MyFile("hi/file.name", "hi", "hi"),
  ];
}
int get imageCount => _images.length;
List<Image> get images => _images;
Image getImageAt(int index) => _images[index];

int get videoCount => _videos.length;
List<MyVideo> get videos => _videos;
MyVideo getVideoAt(int index) => _videos[index];

int get fileCount => _files.length;
List<MyFile> get files => _files;
MyFile getFileAt(int index) => _files[index];
}