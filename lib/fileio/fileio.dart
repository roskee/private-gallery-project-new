import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'filedescriptors.dart';

class FileIO {
  static const String THEME = 'theme';
  static const String USE_FINGERPRINT = 'usefingerprint';
  static const String PASSWORD = 'password';
  static const String LOCKDELAY = 'lockdelay';
  static const String NOOBIE = 'noobie';

  static FileIO _fileIo;
  List<Image> _images = [];
  List<MyVideo> _videos = [];
  List<MyFile> _files = [];
  SharedPreferences _preferences;
  Directory _directory;
  Directory _externalStorage;
  FileIO._();

  static Future<FileIO> getFutureInstance() async {
    if (_fileIo != null) return _fileIo;
    _fileIo = FileIO._();
    _fileIo._preferences = await SharedPreferences.getInstance();
    _fileIo._directory = await getApplicationDocumentsDirectory();
    _fileIo._externalStorage = Directory('/');
    _fileIo._initFiles();
    return _fileIo;
  }

  void _initFiles() {
    // load from file
    if (_preferences.getKeys().length <= 0) setDefaultPreferences();
    _images = [
      Image.asset('assets/images/private_gallery_icon.png'),
      Image.asset('assets/images/private_gallery_icon.png'),
      Image.asset('assets/images/private_gallery_icon.png'),
      Image.asset('assets/images/private_gallery_icon.png'),
      Image.asset('assets/images/private_gallery_icon.png'),
      Image.asset('assets/images/private_gallery_icon.png'),
    ];
    _videos = [
      MyVideo("assets/videos/test3.mp4", "hi", "hi"),
      MyVideo("assets/videos/test.mp4", "hi", "hi"),
      MyVideo("assets/videos/testtwo.mp4", "hi", "hi"),
      MyVideo("assets/videos/test.mp4", "hi", "hi"),
      MyVideo("assets/videos/test.mp4", "hi", "hi"),
    ];
    _files = [
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

  void setDefaultPreferences() {
    _preferences.setString(THEME, 'system');
    _preferences.setBool(USE_FINGERPRINT, false);
    _preferences.setBool(NOOBIE, true);
  }

  void _commitChanges() {}

  SharedPreferences get preferences => _preferences;
  Directory get externalStorage => _externalStorage;

  int get imageCount => _images.length;
  List<Image> get images => _images;
  Image getImageAt(int index) => _images[index];
  void setImage(String path) {}

  int get videoCount => _videos.length;
  List<MyVideo> get videos => _videos;
  MyVideo getVideoAt(int index) => _videos[index];
  void setVideo(String path) {}

  int get fileCount => _files.length;
  List<MyFile> get files => _files;
  MyFile getFileAt(int index) => _files[index];
  void setFile(String path) {}
}
