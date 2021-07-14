import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/fileio/filedescriptors.dart';
import 'package:private_gallery/fileio/fileio.dart';

class HomeFileList extends StatelessWidget {
  final FileIO fileIo;
  HomeFileList(this.fileIo);
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: fileIo.fileCount,
        itemBuilder: (context, index) => ListTile(
              onTap: () {
                showModalBottomSheet(context: context, builder: (context) =>BottomSheet(onClosing: (){}, builder:(context)=>
                Container(
                  height: 180,
                child:Column(children:[
                  ListTile(title: Text(fileIo.getFileAt(index).name),
                  subtitle: Text('created on: ${MyFile.getFormalDate(fileIo.getFileAt(index).dateCreated)}'),),
                  ButtonBar(
                    children: [
                      TextButton.icon(onPressed: (){}, label: Text('Open'),icon: Icon(Icons.open_with)),
                      TextButton.icon(onPressed: (){}, label: Text('Restore'),icon: Icon(Icons.restore),),
                      TextButton.icon(onPressed: (){}, label: Text('Delete'),icon:Icon(Icons.delete))
                    ],
                  )
                ]))));
              },
              leading: Icon(Icons.file_present),
              title: Text(fileIo.getFileAt(index).name),
              subtitle: Text(MyFile.getFormalDate(fileIo.getFileAt(index).dateCreated)),
            ));
  }
}
