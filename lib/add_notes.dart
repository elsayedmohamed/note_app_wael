import 'package:flutter/material.dart';
import 'package:note_app_wael/home_page.dart';
import 'package:note_app_wael/sql_db.dart';

class AddNotesScreen extends StatefulWidget {
  static const addNotesScreen = 'add_notes_screen';
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  SqlDb sqlDb = SqlDb();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                  ),
                  TextFormField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      hintText: 'Note',
                    ),
                  ),
                  TextFormField(
                    controller: colorController,
                    decoration: const InputDecoration(
                      hintText: 'Color',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      int res = await sqlDb.insertData('''
                INSERT INTO 'note'(`title`,`note`,`color`)
                VALUES 
               ("${titleController.text}","${noteController.text}","${colorController.text}")

                                            ''');
                      print(res);

                      if (res > 0) {
                        Navigator.pushNamed(context,'/');
                      }
                      setState(() {});
                    },
                    child: const Text('Add note'),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
