import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/model/todo_model.dart';
import 'package:test1/theme/custom_theme.dart';
import 'package:test1/todo_bloc/todo_bloc.dart';

import 'home.dart';

void main() {
  if (!Platform.isIOS) {
    runApp(CupertinoApp(
      localizationsDelegates: [DefaultMaterialLocalizations.delegate],
      home: MyApp(),
    ));
  } else {
    runApp(MultiBlocProvider(
      providers: [BlocProvider(create: ((context) => TodoBloc()..add(LoadTodoEvent(todos: [
    Todo(id: 1.toString(), task: "kochen"),
    Todo(id: 2.toString(), task: "einkaufen")
  ]))))],
      child: const MyApp(),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blueGrey),
      //theme: CustomTheme.darkTheme,
      home: MyHome(),
    );
  }
}
