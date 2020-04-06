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

  Widget _buildTodoList(){
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length){
          return _buildTodoItem(_todoItems[index]);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText){
    return new ListTile(
      title: Text(todoText),
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