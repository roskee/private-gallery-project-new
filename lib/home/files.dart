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
                showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheet(
                        onClosing: () {},
                        builder: (context) => Container(
                            height: 180,
                            child: Column(children: [
                              ListTile(
                                title: Text(fileIo.getFileAt(index).name),
                                subtitle: Text(
                                    'created on: ${MyFile.getFormalDate(fileIo.getFileAt(index).dateCreated)}'),
                              ),
                              ButtonBar(
                                children: [
                                  TextButton.icon(
                                      onPressed: () {
                                        // OpenFile);
                                      },
                                      onLongPress: (){},
                                      label: Text('Open',style: TextStyle(
                                        color: Theme.of(context).accentColor
                                      ),),
                                      icon: Icon(Icons.open_with,color: Theme.of(context).accentColor,)),
                                  TextButton.icon(
                                    onPressed: () {},
                                    onLongPress: (){},
                                    label: Text('Restore',style: TextStyle(
                                        color: Theme.of(context).accentColor
                                      )),
                                    icon: Icon(Icons.restore,color: Theme.of(context).accentColor),
                                  ),
                                  TextButton.icon(
                                      onPressed: () {},
                                      onLongPress: (){},
                                      label: Text('Delete',style: TextStyle(
                                        color: Theme.of(context).accentColor
                                      )),
                                      icon: Icon(Icons.delete,color: Theme.of(context).accentColor))
                                ],
                              )
                            ]))));
              },
              leading: Icon(Icons.storage,color: Theme.of(context).accentColor),
              title: Text(fileIo.getFileAt(index).name),
              subtitle: Text(
                  MyFile.getFormalDate(fileIo.getFileAt(index).dateCreated)),
            ));
  }
}
