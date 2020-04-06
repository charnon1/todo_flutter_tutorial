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
  createState() => new TodoListState();

}

class TodoListState extends State<TodoList> {

  List<String> _todoItems = [];

  void _addTodoItem(){
    setState((){
      int index = _todoItems.length;
      _todoItems.add("Item " + index.toString());
    });
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
        onPressed: _addTodoItem,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }

}