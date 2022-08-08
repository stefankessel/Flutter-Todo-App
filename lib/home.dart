import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/animation_screen.dart';

import 'add_todo_screen.dart';
import 'model/todo_model.dart';
import 'todo_bloc/todo_bloc.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  //List<String> todos = ["einkaufen", "kochen"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyApp"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (() {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyAddTodoScreen()));
            }),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Add Todo",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.todos.length,
                    itemBuilder: ((context, index) {
                      return _todoCard(state.todos[index], context);
                    }),
                  )
                ],
              ),
            );
          }
          else{
            return Text("Something went wrong");
          }
        },
      ),
    );
  }

  Dismissible _todoCard(Todo todo, BuildContext context) {
    bool isDismissableConfirmed = false;
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.green,
        margin: const EdgeInsets.only(bottom: 10),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Confirm delete"),
              actions: [
                TextButton(
                  onPressed: (() {
                    isDismissableConfirmed = true;
                    Navigator.of(context).pop();
                  }),
                  child: const Text("Confirm"),
                ),
                TextButton(
                  onPressed: (() {
                    isDismissableConfirmed = false;
                    Navigator.of(context).pop();
                  }),
                  child: const Text("Cancel"),
                )
              ],
            );
          },
        );
        return isDismissableConfirmed;
      },
      child: Card(
          elevation: 20,
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" ${todo.task}"),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (() {}),
                        icon: const Icon(Icons.add_task),
                      ),
                      IconButton(
                        onPressed: (() {}),
                        icon: const Icon(Icons.cancel),
                      )
                    ],
                  ),
                ]),
          )),
    );
  }
}
