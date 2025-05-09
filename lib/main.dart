import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_bloc/bloc/todo_bloc.dart';
import 'package:to_do_bloc/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final tempDir = await getTemporaryDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(tempDir.path),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TODO APP",
      home: BlocProvider<TodoBloc>(
        create: (context) => TodoBloc()..add(TodoStarted()),
        child: HomeScreen(),
      ),
    );
  }
}
