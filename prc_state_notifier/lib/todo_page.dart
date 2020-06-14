
import 'package:flutter/material.dart';
import 'package:prc_state_notifier/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  final TextEditingController _textEditController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      body: TodoList(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            show(context);
          },
        child: Icon(Icons.add),
      ),
    );
  }

  show(context) {
    showDialog(
        context: context,
        builder: (context) => Form(
          key: _formKey,
          child: AlertDialog(
            title: Text('Add Todo'),
            content: TextFormField(
              validator: (text) {
                if (text.isEmpty) return "Requied Field";
                return null;
              },
              controller: _textEditController,
              decoration: InputDecoration(
                hintText: 'Add Todo',
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _textEditController.clear();
                  },
                  child: Text('CANCEL')
              ),
              FlatButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      context.read<TodoController>().add(_textEditController.text);
                    }
                    Navigator.pop(context);
                    _textEditController.clear();
                  },
                  child: Text('SAVE')
              ),
            ],
          ),
        ),
    );
  }
}

class TodoList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final todos = context.select((List<String> state) => state);
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0.0,
            child: ListTile(
              title: Text(todos[index]),
              trailing: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => context.read<TodoController>().remove(index),
              ),
            ),
          );
        });
  }
}
