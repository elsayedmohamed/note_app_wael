import 'package:flutter/material.dart';
import 'package:note_app_wael/sql_db.dart';

class EditNotesScreen extends StatefulWidget {
  final id;
  final title;
  final note;
  final color;
  const EditNotesScreen(
      {super.key, this.id, this.title, this.note, this.color});

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  SqlDb sqlDb = SqlDb();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.title;
    noteController.text = widget.note;
    colorController.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
                      int res = await sqlDb.updateData('''
               UPDATE note SET 
               title = "${titleController.text}",
               note ="${noteController.text}",
               color ="${colorController.text}"
               WHERE id = ${widget.id}

                                            ''');
                      print(res);

                      if (res > 0) {
                        Navigator.pushNamed(context, '/');
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
