import 'dart:io';
import 'package:flutter/material.dart';

 class MyFile {
  String _path;
  DateTime _dateCreated;
  String _id;
  String _name;
  String _lastPath;
  File _file;
  MyFile(this._path, this._id,this._lastPath){
    _file = File(_path);
    _name = _lastPath.substring(_lastPath.lastIndexOf('/')+1);
    _dateCreated = DateTime.now();
  }
  static String getFormalDate(DateTime date){
    String hour = (date.hour == 0 )? "12"
                  :(date.hour<12)?"0${date.hour}"
                  :(date.hour>12)?"${date.hour-12}"
                  :"12";
    return "${date.day}/${date.month}/${date.year} - $hour:${date.minute} ${date.hour<12?'AM':'PM'}";
  }
  Map<String,dynamic> toJson(){
    return {
      'path':_path,
      'id':_id,
      'name':_name,
      'lastpath':_lastPath,
      'datecreated': _dateCreated
    };
  }
  MyFile.fromJson(Map<String,dynamic> json): this(json['path'],json['id'],json['lastpath']);
  String get path => _path;
  String get lastPath => _lastPath;
  String get name => _name;
  String get id => _id;
  File get file => _file;
  DateTime get dateCreated => _dateCreated;
}

class MyImage extends MyFile{
  Image _image;
  MyImage(String path, String id, String lastPath) : super(path,id,lastPath){
    this._image = Image.file(_file);
  }
  MyImage.fromJson(Map<String,dynamic> json) : super (json['path'],json['id'], json['lastpath']){
   this._image = Image.file(_file);
  }
  Image get image => _image;
}

class MyVideo extends MyFile{
  Image _thumb;
  String _thumbPath;
  // we need video ui file here
  MyVideo(String path, String id, String lastpath) : super(path,id,lastpath){
    _thumbPath = getThumb();
    _thumb = Image.asset(_thumbPath);
  }
  MyVideo.fromJson(Map<String,dynamic> json) : super (json['path'],json['id'], json['lastpath']){
   this._thumbPath = json['thumb'];
   this._thumb = Image.file(json['thumb']);
  }
  @override
  Map<String,dynamic> toJson(){
    return {
      'path':_path,
      'id':_id,
      'name':_name,
      'lastpath':_lastPath,
      'datecreated': _dateCreated,
      'thumb': _thumbPath
    };
  }
  String getThumb(){
    return 'assets/images/private_gallery_icon.png';
  }
  Image get thumb => _thumb;
}