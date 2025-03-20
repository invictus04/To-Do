import 'package:database/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/local/db_helper.dart';

class AddNote extends StatelessWidget {
  bool flag;
  String title;
  String desc;
  int sno;
  // DBHelper? dbHelper = DBHelper.getInstance;
  var titleController = TextEditingController();
  var descController = TextEditingController();

  AddNote({this.flag = false, this.sno = 0, this.title = "", this.desc = ""});

  @override
  Widget build(BuildContext context) {
    if(flag){
      titleController.text = title;
      descController.text = desc;
    }
    return Scaffold(
       appBar: AppBar(
         title: Text('Add Note'),
         centerTitle: true,
       ),
      body:  Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  // Text(
                  //   flag ? 'Update Note' : 'Add the task',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  // ),
                  // SizedBox(height: 18),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Enter your Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                      label: Text('Title'),
                    ),
                  ),
                  SizedBox(height: 18),
                  TextField(
                    controller: descController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Enter your Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                      label: Text('Description'),
                    ),
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            var mTitle = titleController.text;
                            var mDesc = descController.text;
                            if (mTitle.isNotEmpty && mDesc.isNotEmpty) {

                              if(flag){
                                context.read<DBProvider>().updateNote(mTitle, mDesc, sno);
                              } else {
                                context.read<DBProvider>().addNote(mTitle, mDesc);
                              }
                              Navigator.pop(context);

                              // bool check =
                              //     flag
                              //         ? await dbHelper!.updateNote(
                              //           mTitle: mTitle,
                              //           mDesc: mDesc,
                              //           sno: sno,
                              //         )
                              //         : await dbHelper!.addNote(
                              //           mTitle: mTitle,
                              //           mDesc: mDesc,
                              //         );
                              // if (check) {
                              //   Navigator.pop(context);
                              // }

                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please fill the required details'),
                                ),
                              );
                            }
                            titleController.clear();
                            descController.clear();
                          },
                          child: Text('Done'),
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );

  }

}