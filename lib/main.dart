import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Task App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FocusTaskPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Task {
  String name;
  int minutes;
  bool isCompleted;

  Task({required this.name, required this.minutes, this.isCompleted = false});
}

class FocusTaskPage extends StatefulWidget {
  @override
  _FocusTaskPageState createState() => _FocusTaskPageState();
}

class _FocusTaskPageState extends State<FocusTaskPage> {
  final _taskController = TextEditingController();
  final _timeController = TextEditingController();
  List<Task> _tasks = [];

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

  void _startTimer(Task task) {
    if (task.minutes > 0 && !task.isCompleted) {
      setState(() {
        Timer(Duration(minutes: task.minutes), () {
          setState(() {
            task.isCompleted = true;
          });
        });
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
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'Neye Odaklanmak İstersiniz?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _timeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ne Kadar Süre?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Görev Ekle'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    title: Text(task.name),
                    subtitle: Text('${task.minutes} dakika'),
                    leading: Icon(
                      task.isCompleted ? Icons.check_circle : Icons.timer,
                      color: task.isCompleted ? Colors.green : Colors.grey,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {
                        _startTimer(task);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    _timeController.dispose();
    super.dispose();
  }
}
