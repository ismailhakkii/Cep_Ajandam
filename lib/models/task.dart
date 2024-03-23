class Task {
  String name;
  int minutes;
  bool isCompleted;
  bool isPaused;
  bool isRunning;

  Task({
    required this.name,
    required this.minutes,
    this.isCompleted = false,
    this.isPaused = false,
    this.isRunning=false,
  });

  get remainingTime => null;
}
