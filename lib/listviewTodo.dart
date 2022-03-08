// ignore: file_names
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loginflutter/Store/todo.dart';
import 'package:loginflutter/Store/todo_list.dart';
import 'package:mobx/mobx.dart';

class listViewTodo extends StatefulWidget {
  const listViewTodo({Key? key}) : super(key: key);

  @override
  State<listViewTodo> createState() => _listViewTodoState();
}

class _listViewTodoState extends State<listViewTodo> {
  @observable
  // ignore: non_constant_identifier_names
  Todo_List? todo_list;
  @override
  Widget build(BuildContext context) {
    todo_list = Todo_List();
    todo_list?.initTodos();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(child: _listViewBuilder()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addDialog(),
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
    return ListTile(
      leading: const Icon(Icons.done),
      title: Text(
        todo_list!.todos[index].description,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        todo_list!.todos[index].description,
      ),
      trailing: const Icon(Icons.navigate_next),
      onLongPress: () => delDialog(index),
    );
  }

  //----ADD DIALOG----//

  final taskDescTextController = TextEditingController();

  addDialog() async {
    taskDescTextController.clear();
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Row(
          children: <Widget>[
            Expanded(
                child: TextField(
                    controller: taskDescTextController,
                    autofocus: true,
                    decoration: const InputDecoration(
                        labelText: 'Task Description: ',
                        hintText: 'eg. Brush your teeth'))),
          ],
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
                todo_list!.addTodo(taskDescTextController.text)
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  //----DELETE DIALOG----//

  bool delDialog(int index) {
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
    return true;
  }
}
