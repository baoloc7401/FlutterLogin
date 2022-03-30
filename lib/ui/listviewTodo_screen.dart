// ignore: file_names
// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loginflutter/store/todo_list.dart';
import 'package:loginflutter/models/login_info_json.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_switch/flutter_switch.dart';

class listViewTodo_screen extends StatefulWidget {
  final Login_Info_Json login_info;
  const listViewTodo_screen(this.login_info, {Key? key}) : super(key: key);

  @override
  State<listViewTodo_screen> createState() => _listViewTodo_screenState();
}

class _listViewTodo_screenState extends State<listViewTodo_screen> {
  bool temp = false;
  @observable
  Todo_List? todo_list;
  @override
  Widget build(BuildContext context) {
    todo_list = Todo_List();
    todo_list?.initTodos();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text("Todo Screen")),
      ),
      body: Center(child: _listViewBuilder()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => inputItemDialog("Add", done: false),
        tooltip: 'Add more tasks',
        child: const Icon(Icons.add),
      ),
    );
  }

  //----LIST VIEW----//

  Widget _listViewBuilder() {
    return Observer(
        builder: (context) => ListView.separated(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  _todoItemsBuilder(index),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: todo_list!.todos.length,
            ));
  }

  //----TO DO ITEMS----//
  Widget _todoItemsBuilder(int index) {
    return Observer(
        builder: (context) => ListTile(
              leading: todo_list!.todos[index].done
                  ? const Icon(Icons.done)
                  : const Icon(Icons.close),
              title: Text(
                todo_list!.todos[index].description,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                todo_list!.todos[index].description,
              ),
              trailing: const Icon(Icons.navigate_next),
              onLongPress: () => delDialog(index),
              onTap: () => inputItemDialog("Update",
                  done: todo_list!.todos[index].done,
                  desc: todo_list!.todos[index].description,
                  index: index),
            ));
  }

  //----INPUT ITEMS DIALOG----//

  final taskDescTextController = TextEditingController();
  @action
  inputItemDialog(String type,
      {bool done = false, String desc = "", int index = -1}) {
    taskDescTextController.text = desc;
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: SizedBox(
            width: double.infinity,
            child: Text(
              type + " Item",
              textAlign: TextAlign.center,
            )),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                        controller: taskDescTextController,
                        autofocus: true,
                        decoration: const InputDecoration(
                            labelText: 'Task Description: ',
                            hintText: 'eg. Brush your teeth')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Status: ",
                          textAlign: TextAlign.center,
                        ),
                        FlutterSwitch(
                          value: done,
                          showOnOff: true,
                          onToggle: (value) => {
                            setState(() {
                              done = value;
                            })
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => {
              Navigator.pop(context, 'Yes'),
              if (taskDescTextController.text.isNotEmpty)
                (type == "Add")
                    ? todo_list!.addTodo(taskDescTextController.text, done)
                    : todo_list!
                        .updateTodo(index, taskDescTextController.text, done)
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  //----DELETE DIALOG----//

  void delDialog(int index) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Delete item!!',
          style: TextStyle(color: Colors.blueAccent),
        ),
        content: const Text('Do you want to delete this item?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () =>
                {Navigator.pop(context, 'Yes'), todo_list!.removeTodoAt(index)},
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
