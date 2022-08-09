import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test1/application/theme_provider/theme_provider.dart';

import 'add_todo_screen.dart';
import 'model/todo_model.dart';
import 'application/todo_bloc/todo_bloc.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  //List<String> todos = ["einkaufen", "kochen"];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
        builder: (context, ThemeService themeServiceState, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("MyApp"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: (() {
                  themeServiceState.toogleTheme();
                }),
                icon: themeServiceState.isDarkMode ? const Icon(Icons.nightlight) : const Icon(Icons.wb_sunny)),
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
                        "Todos",
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
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          },
        ),
      );
    });
  }

  Dismissible _todoCard(Todo todo, BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.green,
        margin: const EdgeInsets.only(bottom: 10),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await _customConfirmationDialog(context: context, todo: todo);
      },
      child: Card(
          elevation: 20,
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(todo.task),
              subtitle: Text(todo.description ?? ""),
              trailing: IconButton(
                onPressed: (() {
                  _displayCrudOptionDialog(context, todo);
                }),
                icon: const Icon(Icons.menu),
              ),
            ),
          )),
    );
  }

  Future<dynamic> _displayCrudOptionDialog(
      BuildContext context, Todo todo) async {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              child: GestureDetector(
                onTap: (() {
                  _customConfirmationDialog(context: context, todo: todo)
                      .then((value) => Navigator.of(context).pop());
                }),
                child: const ListTile(
                  title: Text("Löschen"),
                  trailing: Icon(Icons.delete),
                ),
              ),
            ),
            const Divider(
              height: 2,
            ),
            SimpleDialogOption(
              child: GestureDetector(
                onTap: () {},
                child: const ListTile(
                  title: Text("Update"),
                  trailing: Icon(Icons.update),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Future _customConfirmationDialog(
    {required BuildContext context, required Todo todo}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Confirm delete"),
        actions: [
          TextButton(
            onPressed: (() {
              //isDismissableConfirmed = true;
              context.read<TodoBloc>().add(DeleteTodoEvent(todo: todo));
              Navigator.of(context).pop(true);
              //Navigator.pushReplacement(context, Mater)
            }),
            child: const Text("Confirm"),
          ),
          TextButton(
            onPressed: (() {
              //isDismissableConfirmed = false;

              Navigator.of(context).pop(false);
            }),
            child: const Text("Cancel"),
          )
        ],
      );
    },
  );
}
