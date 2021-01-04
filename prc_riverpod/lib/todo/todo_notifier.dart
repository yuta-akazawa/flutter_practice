import 'package:flutter_riverpod/all.dart';
import 'package:prc_riverpod/todo/task.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier(List<Task> tasks) : super(tasks ?? []);

  void addTask(String title) {
    state = [...state, Task(title: title)];
  }

  void toggleDone(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(id: task.id, title: task.title, isDone: !task.isDone)
        else
          task
    ];
  }

  void deleteTask(Task target) {
    state = state.where((task) => task.id != target.id).toList();
  }

  void deleteAllTasks() {
    state = [];
  }

  void deleteDoneTasks() {
    state = state.where((task) => !task.isDone).toList();
  }

  void updateTasks(List<Task> newTasks) {
    state = [for (final task in newTasks) task];
  }
}

final StateNotifierProvider<TaskNotifier> taskListProvider =
    StateNotifierProvider((ref) => TaskNotifier([Task(title: 'play tennis')]));

final Provider<int> isNotDoneTasksCount = Provider((ref) {
  return ref.read(taskListProvider.state).where((task) => !task.isDone).length;
});

enum Filter {
  all,
  active,
  done,
}

final StateProvider<Filter> filterProvider = StateProvider((ref) => Filter.all);

final Provider<List<Task>> filteredTasks = Provider((ref) {
  final filter = ref.read(filterProvider);
  final tasks = ref.read(taskListProvider.state);
  switch (filter.state) {
    case Filter.done:
      return tasks.where((task) => task.isDone).toList();
    case Filter.active:
      return tasks.where((task) => !task.isDone).toList();
    case Filter.all:
    default:
      return tasks;
  }
});
