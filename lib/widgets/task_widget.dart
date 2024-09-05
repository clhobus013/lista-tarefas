import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  final String title;
  final String description;
  final bool isChecked;
  final Function toggleTask;
  final Function removeTask;

  const TaskWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.isChecked,
      required this.toggleTask,
      required this.removeTask});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      //This one
      leading: checkBoxWidget(),
      title: Text(widget.title),
      subtitle: Text(widget.description),
      trailing: TextButton(
          onPressed: () => showDialog(
              context: context,
              builder: (_) => alert(),
              barrierDismissible: false),
          child: const Icon(Icons.delete)),
    );
  }

  Color getColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return const Color.fromARGB(255, 76, 116, 175);
    }
    return const Color.fromARGB(255, 255, 255, 255);
  }

  Widget checkBoxWidget() {
    return Checkbox(
      checkColor: const Color.fromARGB(255, 255, 255, 255),
      fillColor: WidgetStateProperty.resolveWith(getColor),
      value: widget.isChecked,
      onChanged: (check) => widget.toggleTask(check),
    );
  }

  Widget noButton() {
    return TextButton(
      child: const Text("Nããããoooo!!!"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget yesButton() => TextButton(
        child: const Text("Siiimmm!!!"),
        onPressed: () {
          widget.removeTask();
          Navigator.of(context).pop();
        },
      );

  AlertDialog alert() {
    return AlertDialog(
      title: const Text("Remover tarefa"),
      content:
          const Text("Tem certeza mesmo, mesmo que quer remover a tarefa?"),
      actions: [
        noButton(),
        yesButton(),
      ],
      elevation: 24,
    );
  }
}
