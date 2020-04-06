import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "To do List",
      home: TodoList(),
      );
    
  }
}


class TodoList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => TodoListState();

}

class TodoListState extends State<TodoList> {

  List<String> _todoItems = [];

  void _addTodoItem(String task){
    if(task.length > 0 ){
      setState(() {
        _todoItems.add(task);
      });
    }
  }

  void _removeTodoItem(int index){
    setState(() {
      _todoItems.removeAt(index);  
    });
  }

  void _promptRemoveTodoItem(int index){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Mark '${_todoItems[index]}' as done?"),
          actions: <Widget>[
            FlatButton(
              child: Text("cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("Done"),
              onPressed: (){
                _removeTodoItem(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  Widget _buildTodoList(){
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length){
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index){
    return new ListTile(
      title: Text(todoText),
      onTap: () => _promptRemoveTodoItem(index),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoScreen(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context){
          return new Scaffold(
            appBar: AppBar(
              title: Text("Add a new task"),
            ),
            body: TextField(
              autofocus: true,
              onSubmitted: (val){
                _addTodoItem(val);
                Navigator.pop(context);
              },
              decoration: new InputDecoration(
                hintText: "Enter something to do...",
                contentPadding: const EdgeInsets.all(16.0)
              ),
            ),
          );
        }
      ),
    );
  }

}