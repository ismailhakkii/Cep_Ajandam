import 'dart:async';
import 'package:flutter_application_1/models/task.dart';

class TaskController {
  Timer? _timer;
  Task? currentTask;
  dynamic Function(int)? onTick;
  dynamic Function()? onComplete;

  void startTimer(Task task, dynamic Function(int) onTickCallback, dynamic Function() onCompleteCallback) {
    if (_timer != null) {
      _timer!.cancel();
    }
    currentTask = task;
    onTick = onTickCallback;
    onComplete = onCompleteCallback;
    int seconds = task.minutes * 60;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds < 1) {
        timer.cancel();
        if (onComplete != null) onComplete!();
      } else {
        seconds--;
        if (onTick != null) onTick!(seconds);
      }
    });
  }

  void pauseTimer(Task task) {
    _timer?.cancel();
    if (currentTask != null && currentTask == task) {
      currentTask!.isPaused = true;
    }
  }

  void resumeTimer(Task task) {
    if (currentTask != null && currentTask == task && onTick != null && onComplete != null) {
      startTimer(currentTask!, onTick!, onComplete!);
    }
  }

  void resetTimer(Task task) {
    _timer?.cancel();
    if (currentTask != null && currentTask == task) {
      currentTask!.isPaused = false;
      currentTask!.isRunning = false;
    }
  }

  void deleteTask(Task task) {
    // Delete task from the list or database
  }

  Stream<int> getRemainingTimeStream(Task task) {
    // Implement logic to provide remaining time for the task
    // Dummy implementation for example purposes:
    return Stream.periodic(Duration(seconds: 1), (int count) {
      return task.minutes * 60 - count; // Replace with actual logic
    });
  }
}
