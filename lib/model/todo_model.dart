class Todo {
  String? id;
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
    isCancelled = isCancelled ?? false;
    isCompleted = isCompleted ?? false;
  }


Todo updateTodo({  String? id,
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
    Todo(id: 1.toString(), task: "kochen"),
    Todo(id: 2.toString(), task: "einkaufen")
  ];
}
