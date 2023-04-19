import 'package:flutter/material.dart';
import 'package:note_app_wael/add_notes.dart';
import 'package:note_app_wael/edit_note.dart';
import 'package:note_app_wael/sql_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  List notes = [];
  Future getData() async {
    SqlDb sqlDb = SqlDb();
    List<Map> data = await sqlDb.readData(" SELECT * FROM 'note' ");
    notes.addAll(data);
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }
    _isLoading = false;
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                SqlDb sqlDb = SqlDb();
                await sqlDb.deleteDataBase();
                setState(() {});
              },
              child: const Text(
                "delete DataBase",
              ),
            ),
            Expanded(
              child: _isLoading == true
                  ? const Center(
                      child: Text('Is loading ....'),
                    )
                  : ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, i) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                tileColor: Colors.amber,
                                title: Text(notes[i]['title']),
                                subtitle: Text(notes[i]['note']),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        SqlDb sqlDb = SqlDb();
                                        int res = await sqlDb.deleteData(
                                            "DELETE FROM note WHERE id =${notes[i]['id']}");

                                        if (res > 0) {
                                          notes.removeWhere((element) =>
                                              element['id'] == notes[i]['id']);
                                          setState(() {});
                                        }
                                        debugPrint('$res');
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditNotesScreen(
                                              id: notes[i]['id'],
                                              title: notes[i]['title'],
                                              note: notes[i]['note'],
                                              color: notes[i]['color'],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNotesScreen.addNotesScreen);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
