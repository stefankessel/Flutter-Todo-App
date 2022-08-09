import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test1/application/theme_provider/theme_provider.dart';
import 'package:test1/model/todo_model.dart';
import 'application/todo_bloc/todo_bloc.dart';

import 'home.dart';
import 'theme/custom_theme.dart';
//import 'theme.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: ((context) => TodoBloc()
            ..add(LoadTodoEvent(
                todos: [Todo(task: "kochen"), Todo(task: "einkaufen")]))))
    ],
    child: ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context,ThemeService themeService, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        /*
          routes: {
            "/root": (context) => const Root(),
            "/todo": (context) => const MyTodo(),
          },
          */
        home: const MyHome(),
      );
    });
  }
}
