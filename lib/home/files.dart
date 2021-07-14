import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/fileio/fileio.dart';

class HomeFileList extends StatelessWidget{
  final FileIO fileIo;
  HomeFileList(this.fileIo);
  Widget build(BuildContext context){
    return ListView.builder(itemCount: fileIo.fileCount,itemBuilder: (context,index)=>
      InkWell(
        onTap: (){
          // popup dialog
        },
        child:ListTile(
        leading: Icon(Icons.file_present),
        title: Text(fileIo.getFileAt(index).name),
        subtitle: Text(fileIo.getFileAt(index).dateCreated.toString()),
      )
    ));
  }
}