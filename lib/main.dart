import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lista_tarefas/models/task.dart';
import 'package:lista_tarefas/screens/task_form_page.dart';
import 'package:lista_tarefas/widgets/task_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Lista de tarefas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _tasks = [
      Task(0, "Comprar Pão", "Mercado do seu Jorge"),
      Task(1, "Finalizar projeto", "Entrega dia 99/99/99"),
      Task(2, "Judo", "Levar a galinha no Judo", isCompleted: true)
    ];

    log(_tasks.toString());
  }

  void _newTask({required id, required title, required description}) {
    setState(() {
      _tasks.add(Task(id, title, description));
    });
  }

  void _removeTask({required task}) {
    setState(() {
      _tasks.remove(task);
    });
  }

  void _toggleTask({required task, required check}) {
    int index = _tasks.indexOf(task);

    setState(() {
      _tasks[index].isCompleted = check;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const Row(
            children: [
              Text("A fazer:",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          ListView(
              shrinkWrap: true,
              children: _tasks
                  .where((task) => !task.isCompleted)
                  .map((task) => TaskWidget(
                      title: task.title,
                      description: task.description,
                      isChecked: task.isCompleted,
                      toggleTask: (check) =>
                          _toggleTask(task: task, check: check),
                      removeTask: () => _removeTask(task: task)))
                  .toList()),
          const Row(
            children: [
              Text(
                "Concluidos:",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          ListView(
              shrinkWrap: true,
              children: _tasks
                  .where((task) => task.isCompleted)
                  .map((task) => TaskWidget(
                      title: task.title,
                      description: task.description,
                      isChecked: task.isCompleted,
                      toggleTask: (check) =>
                          _toggleTask(task: task, check: check),
                      removeTask: () => _removeTask(task: task)))
                  .toList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskFormPage(saveTask: _newTask),
          ),
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
