import 'package:database/AddNote_Page.dart';
import 'package:database/data/local/db_helper.dart';
import 'package:database/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // List<Map<String, dynamic>> allNotes = [];
  //DBHelper? dbHelper;
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DBProvider>().getInitialNotes();

    // dbHelper = DBHelper.getInstance;
    // getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Notes')),
      body:
          Consumer<DBProvider>(builder: (context, provider, child) {
            List<Map<String,dynamic>> allNotes = provider.getNotes();
            return allNotes.isNotEmpty
                ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${allNotes[index][DBHelper.COLUMN_SNO]}'),
                  title: Text(allNotes[index][DBHelper.COLUMN_TITLE]),
                  subtitle: Text(allNotes[index][DBHelper.COLUMN_DESC]),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // titleController.text =
                            //     allNotes[index][DBHelper.COLUMN_TITLE];
                            // descController.text =
                            //     allNotes[index][DBHelper.COLUMN_DESC];
                            // bottomSheet(
                            //   flag: true,
                            //   sno: allNotes[index][DBHelper.COLUMN_SNO],
                            // );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AddNote(
                                  flag: true,
                                  sno: allNotes[index][DBHelper.COLUMN_SNO],
                                  title: allNotes[index][DBHelper.COLUMN_TITLE],
                                  desc: allNotes [index][DBHelper.COLUMN_DESC],
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            // bool isDelete = await dbHelper!.deleteNote(
                            //   sno: allNotes[index][DBHelper.COLUMN_SNO],
                            // );
                            // if (isDelete) {
                            //   getNotes();
                            // }
                            context.read<DBProvider>().deleteNode(allNotes[index][DBHelper.COLUMN_SNO]);


                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
                : Center(child: Container(child: Text('some error occured')));
          },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNote()),
          );
          // titleController.clear();
          // descController.clear();
          // bottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // void getNotes() async {
  //   allNotes = await dbHelper!.getAllNotes();
  //   setState(() {});
  // }

  // void bottomSheet({bool flag = false, int sno = 0}) {
  //   showModalBottomSheet(
  //     showDragHandle: true,
  //     context: context,
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.only(left: 10, right: 10),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //
  //           children: [
  //             Text(
  //               flag ? 'Update Note' : 'Add the task',
  //               textAlign: TextAlign.center,
  //               style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
  //             ),
  //             SizedBox(height: 18),
  //             TextField(
  //               controller: titleController,
  //               decoration: InputDecoration(
  //                 hintText: "Enter your Description",
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(21),
  //                 ),
  //                 label: Text('Title'),
  //               ),
  //             ),
  //             SizedBox(height: 18),
  //             TextField(
  //               controller: descController,
  //               maxLines: 4,
  //               decoration: InputDecoration(
  //                 hintText: "Enter your Description",
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(21),
  //                 ),
  //                 label: Text('Description'),
  //               ),
  //             ),
  //             SizedBox(height: 18),
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: ElevatedButton(
  //                     onPressed: () async {
  //                       var mTitle = titleController.text.toString();
  //                       var mDesc = descController.text.toString();
  //                       if (mTitle.isNotEmpty && mDesc.isNotEmpty) {
  //                         bool check =
  //                             flag
  //                                 ? await dbHelper!.updateNote(
  //                                   mTitle: mTitle,
  //                                   mDesc: mDesc,
  //                                   sno: sno,
  //                                 )
  //                                 : await dbHelper!.addNote(
  //                                   mTitle: mTitle,
  //                                   mDesc: mDesc,
  //                                 );
  //                         if (check) {
  //                           getNotes();
  //                         }
  //                       } else {
  //                         ScaffoldMessenger.of(context).showSnackBar(
  //                           SnackBar(
  //                             content: Text('Please fill the required details'),
  //                           ),
  //                         );
  //                       }
  //                       titleController.clear();
  //                       descController.clear();
  //                       Navigator.pop(context);
  //                     },
  //                     child: Text('Done'),
  //                   ),
  //                 ),
  //                 SizedBox(width: 18),
  //                 Expanded(
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Text('Cancel'),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
