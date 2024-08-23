import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text("TESTE"),
        ],
      ),
    );
  }

}