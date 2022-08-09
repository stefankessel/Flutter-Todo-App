import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'application/todo_bloc/todo_bloc.dart';
import 'model/todo_model.dart';

class MyAddTodoScreen extends StatelessWidget {
  MyAddTodoScreen({Key? key}) : super(key: key);
  final TextEditingController _taskInputController = TextEditingController();
  final TextEditingController _descriptionInputController =
      TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo"),),
      body: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Added Todo"),
              duration: Duration(seconds: 2),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _inputFormField("title", _taskInputController),
                _inputFormField("description", _descriptionInputController),
                ElevatedButton(
                    onPressed: (() {
                      Todo todo = Todo(
                          task: _taskInputController.value.text,
                          description: _descriptionInputController.value.text);

                      if (todo.task.isNotEmpty) {
                        context.read<TodoBloc>().add(AddTodoEvent(todo: todo));
                        _taskInputController.clear();
                        _descriptionInputController.clear();
               
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                            "No Title added",
                          ),
                          backgroundColor: Colors.redAccent,
                        ));
                      }
                    }),
                    
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: const Text("Add Todo"),),
              ],
            ),
          )),
    );
  }

  Column _inputFormField(String inputInfo, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          inputInfo,
          style: const TextStyle(fontSize: 18),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: TextFormField(
            autofocus: inputInfo == "title" ? true : false,
            controller: controller,
          ),
        ),
      ],
    );
  }
}
