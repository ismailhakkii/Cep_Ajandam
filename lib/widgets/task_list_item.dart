import 'package:flutter/material.dart';
import '../models/task.dart';
import '../controllers/task_controller.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final TaskController controller;
  final VoidCallback onDismissed;

  const TaskListItem({
    Key? key,
    required this.task,
    required this.controller,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.name),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        // UI'dan task'ı çıkarmak için callback kullanılır
        onDismissed();
      },
      child: ListTile(
        title: Text(task.name),
        subtitle: StreamBuilder<int>(
          stream: controller.getRemainingTimeStream(task),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final minutes = snapshot.data! ~/ 60;
              final seconds = snapshot.data! % 60;
              return Text('$minutes dakika $seconds saniye');
            } else {
              return Text('${task.minutes} dakika');
            }
          },
        ),
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.timer,
          color: task.isCompleted ? Colors.green : Colors.grey,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (!task.isCompleted) ...[
              IconButton(
                icon: Icon(task.isRunning ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  if (task.isRunning) {
                    controller.pauseTimer(task);
                  } else {
                    controller.resumeTimer(task);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.stop),
                onPressed: () {
                  controller.resetTimer(task);
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
