import 'package:flutter/material.dart';
import '../widgets/app_bar_design.dart';

class TodosAdd extends StatefulWidget {
  const TodosAdd({super.key});

  @override
  State<TodosAdd> createState() => _TodosAddState();
}

class _TodosAddState extends State<TodosAdd> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDesign(),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you going to do?',
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Successfully added!'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.blueGrey,
                    ),
                  );
                  Navigator.pop(context, _textController.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please input something before adding'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.blueGrey,
                    ),
                  );
                }
              },
              child: const Text('+ ADD'),
            ),
          ],
        ),
      ),
    );
  }
}
