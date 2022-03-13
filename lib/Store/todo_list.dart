// ignore_for_file: camel_case_types

import 'package:mobx/mobx.dart';
import 'package:loginflutter/Store/todo.dart';
part 'todo_list.g.dart';

class Todo_List = _Todo_List with _$Todo_List;

enum VisibitiyFilter { all, pending, completed }

abstract class _Todo_List with Store {
  @observable
  ObservableList<Todo> todos = ObservableList<Todo>();
  @observable
  VisibitiyFilter filter = VisibitiyFilter.all;
  @action
  void initTodos() {
    for (var i = 0; i < 10; i++) {
      todos.add(Todo("Task - " + i.toString()));
    }
  }

  @action
  removeTodoAt(int index) {
    todos.removeAt(index);
  }

  @action
  addTodo(String des, bool done) {
    todos.add(Todo(des, done: done));
  }

  @action
  updateTodo(int index, String des, bool done) {
    todos[index].description = des;
    todos[index].done = done;
  }
}
