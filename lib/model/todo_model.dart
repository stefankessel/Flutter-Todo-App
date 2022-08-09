import 'package:flutter/material.dart';

class Todo {
  UniqueKey? id;
  String task;
  String? description;
  bool? isCancelled;
  bool? isCompleted;

  Todo(
      {this.id,
      required this.task,
      this.description,
      this.isCancelled,
      this.isCompleted}) {
        id = UniqueKey();
    isCancelled = isCancelled ?? false;
    isCompleted = isCompleted ?? false;
  }


Todo updateTodo({  UniqueKey? id,
  String? task,
  String? description,
  bool? isCancelled,
  bool? isCompleted,}){
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      isCancelled: isCancelled ?? this.isCancelled,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static List<Todo> todos =[
    Todo(task: "kochen"),
    Todo(task: "einkaufen")
  ];
}
