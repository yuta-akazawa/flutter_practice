import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prc_riverpod/todo/task.dart';
import 'package:prc_riverpod/todo/task_tile.dart';
import 'package:prc_riverpod/todo/todo_notifier.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _newTaskTitle = '';
    final _textEditingController = TextEditingController();

    // テキスト入力完了かTextFieldの×を押したら入力中の文字を消す
    void clearTextField() {
      _textEditingController.clear();
      _newTaskTitle = '';
    }

    // タスクを消したらSnackBar表示、restoreで元に戻せる
    void showSnackBar({
      List<Task> previousTasks,
      TaskNotifier taskList,
      String content,
      ScaffoldState scaffoldState,
    }) {
      // SnackBar表示中にタスク削除したら、前のSnackBarを消すためにremoveを最初に入れている
      // ignore: deprecated_member_use
      scaffoldState.removeCurrentSnackBar();
      final snackBar = SnackBar(
        content: Text(content),
        action: SnackBarAction(
          label: 'restore',
          onPressed: () {
            // 消す前のタスクリストで更新して削除したタスクを復活させる
            taskList.updateTasks(previousTasks);
            // ignore: deprecated_member_use
            scaffoldState.removeCurrentSnackBar();
            scaffoldState.removeCurrentSnackBar();
          },
        ),
        duration: const Duration(seconds: 3),
      );
      // ignore: deprecated_member_use
      // scaffoldState.showSnackBar(snackBar);
      scaffoldState.showBottomSheet((context) => snackBar);
    }

    return MaterialApp(
      home: Scaffold(
        body: Consumer(
          builder: (_, watch, __) {
            final taskList = watch(taskListProvider);
            final allTasks = watch(taskListProvider.state);
            final displayedTasks = watch(filteredTasks);
            final filter = watch(filterProvider);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'ToDo List',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          child: TextField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: 'Enter a todo title',
                              suffixIcon: IconButton(
                                onPressed: clearTextField,
                                icon: Icon(Icons.clear),
                              ),
                            ),
                            textAlign: TextAlign.start,
                            onChanged: (newText) {
                              _newTaskTitle = newText;
                            },
                            onSubmitted: (newText) {
                              if (_newTaskTitle.isEmpty) {
                                _newTaskTitle = 'No Title';
                              }
                              taskList.addTask(_newTaskTitle);
                              clearTextField();
                            },
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${watch(isNotDoneTasksCount)} tasks left',
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('All'),
                                  ),
                                  onTap: () => filter.state = Filter.all,
                                ),
                                InkWell(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Active'),
                                  ),
                                  onTap: () => filter.state = Filter.active,
                                ),
                                InkWell(
                                  onTap: () => filter.state = Filter.done,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Done'),
                                  ),
                                ),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      'Delete Done',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    final doneTasks = allTasks
                                        .where((task) => task.isDone)
                                        .toList();
                                    if (doneTasks.isNotEmpty) {
                                      taskList.deleteDoneTasks();
                                      showSnackBar(
                                        previousTasks: allTasks,
                                        taskList: taskList,
                                        content:
                                            'Done tasks have been deleted.',
                                        scaffoldState: Scaffold.of(context),
                                      );
                                    }
                                  },
                                ),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      'Delete All',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (allTasks.isNotEmpty) {
                                      taskList.deleteAllTasks();
                                      showSnackBar(
                                        previousTasks: allTasks,
                                        taskList: taskList,
                                        content: 'All tasks have been deleted.',
                                        scaffoldState: Scaffold.of(context),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final task = displayedTasks[index];
                        return TaskTile(
                          taskTitle: task.title,
                          isChecked: task.isDone,
                          checkCallback: (bool value) {
                            taskList.toggleDone(task.id);
                          },
                          longPressCallback: () {
                            taskList.deleteTask(task);
                            showSnackBar(
                              previousTasks: displayedTasks,
                              taskList: taskList,
                              content: '${task.title} has been deleted.',
                              scaffoldState: Scaffold.of(context),
                            );
                          },
                        );
                      },
                      itemCount: displayedTasks.length,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
