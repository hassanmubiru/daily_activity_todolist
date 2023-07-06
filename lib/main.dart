import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ),
        // useMaterial3: true, // Remove this line
      ),
      home: const DailyActivityTodoList(),
    );
  }
}

class DailyActivityTodoList extends StatefulWidget {
  const DailyActivityTodoList({Key? key});

  @override
  State<DailyActivityTodoList> createState() => _DailyActivityTodoListState();
}

class _DailyActivityTodoListState extends State<DailyActivityTodoList> {
  List<String> todos = [];
  Set<String> completed = {};

  void addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTodo = '';

        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            onChanged: (value) {
              newTodo = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  todos.add(newTodo);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void toggleComplete(String todo) {
    setState(() {
      if (completed.contains(todo)) {
        completed.remove(todo);
      } else {
        completed.add(todo);
      }
    });
  }

  void delete(String todo) {
    setState(() {
      todos.remove(todo);
      completed.remove(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Activity TodoList'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          final isComplete = completed.contains(todo);
          return ListTile(
            title: Text(
              todo,
              style: TextStyle(
                decoration: isComplete ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => toggleComplete(todo),
                  icon: Icon(
                    isComplete ? Icons.check_box : Icons.check_box_outline_blank,
                  ),
                ),
                IconButton(
                  onPressed: () => delete(todo),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
