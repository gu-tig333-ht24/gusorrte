import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class AppBarDesign extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  const AppBarDesign({super.key, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 81, 128, 214),
      foregroundColor: Colors.white,
      title: Text("TIG333 TODO"),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.0);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  //Will find way to clean this up
                  child: Text("All"),
                ),
                const PopupMenuItem(
                  child: Text("Done"),
                ),
                const PopupMenuItem(
                  child: Text("Undone"),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView(
        //Will eventually put this into a list but kept this as this for now as an example
        children: [
          ListTile(
            leading: Checkbox(
              value: false,
              onChanged: (bool? value) {},
            ),
            title: Text(
              "Task 1",
              style: TextStyle(fontSize: 20),
            ),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {},
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodosAdd()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodosAdd extends StatelessWidget {
  const TodosAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDesign(),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(22.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you going to do?',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('+ ADD'),
            ),
          ],
        ),
      ),
    );
  }
}
