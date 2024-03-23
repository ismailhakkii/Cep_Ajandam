import 'package:flutter/material.dart';
import '../models/task.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_list_item.dart';

class FocusTaskPage extends StatefulWidget {
  const FocusTaskPage({Key? key}) : super(key: key);

  @override
  State<FocusTaskPage> createState() => _FocusTaskPageState();
}

class _FocusTaskPageState extends State<FocusTaskPage> {
  final _taskController = TextEditingController();
  final _timeController = TextEditingController();
  final List<Task> _tasks = [];
  final TaskController _taskControllerInstance = TaskController();

  void _addTask() {
    final String taskName = _taskController.text;
    final int time = int.tryParse(_timeController.text) ?? 0;
    if (taskName.isNotEmpty && time > 0) {
      setState(() {
        _tasks.add(Task(name: taskName, minutes: time));
        _taskController.clear();
        _timeController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cep Ajandam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Görev adı girilecek TextField
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'Neye Odaklanmak İstersiniz?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            // Görev süresi girilecek TextField
            TextField(
              controller: _timeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ne Kadar Süre?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            // Görev ekleme butonu
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Görev Ekle'),
            ),
            // Görev listesi
            Expanded(
  child: ListView.builder(
    itemCount: _tasks.length,
    itemBuilder: (context, index) {
      final task = _tasks[index];
      return TaskListItem(
        task: task,
        controller: _taskControllerInstance,
        onDismissed: () => _deleteTask(index),
      );
    },
  ),
),
          ],
        ),
      ),
    );
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }
  
  @override
  void dispose() {
    _taskController.dispose();
    _timeController.dispose();
    super.dispose();
  }
}
