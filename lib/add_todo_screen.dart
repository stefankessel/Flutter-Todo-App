import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/model/todo_model.dart';
import 'package:test1/todo_bloc/todo_bloc.dart';

class MyAddTodoScreen extends StatelessWidget {
  MyAddTodoScreen({Key? key}) : super(key: key);
  final TextEditingController _taskInputController = TextEditingController();
  final TextEditingController _descriptionInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                _inputFormField("title", _taskInputController),
                _inputFormField("description", _descriptionInputController),
                ElevatedButton(
                    onPressed: (() {
                      Todo todo = Todo(
                          task: _taskInputController.value.text,
                          description: _descriptionInputController.value.text);
                      _taskInputController.clear();
                      _descriptionInputController.clear();
                    }),
                    child: Text("Add Todo"),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    )),
              ],
            ),
          );
        },
      ),
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
