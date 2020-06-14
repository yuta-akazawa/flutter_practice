
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_notifier/state_notifier.dart';

class TodoController extends StateNotifier<List<String>> with LocatorMixin {
  TodoController() : super([]){
    load();
  }

  add(String todo) {
    state.add(todo);
    save();
  }

  remove(int index) {
    if (index >= 0 && index < state.length) {
      state.removeAt(index);
      save();
    }
  }

  load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = prefs.getStringList('todos');
    if (state == null) state = [];
  }

  save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todos', state);
  }

}