import 'package:flutter/material.dart';
import 'package:lab_03/widgets/date_time_text.dart';
import 'package:lab_03/widgets/new_item.dart';

import 'model/exam_list_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIS - Lab03',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Exam Management App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ExamListItem> _listItems = [
    ExamListItem(name: 'Databases', dateTime: DateTime(2023, 2, 9, 8)),
    ExamListItem(
        name: 'Probability and Statistics',
        dateTime: DateTime(2023, 2, 9, 12, 30))
  ];

  void _addItemFunction(BuildContext ct) {
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewItem(_addNewItemToList));
        });
  }

  void _addNewItemToList(ExamListItem item) {
    setState(() {
      _listItems.add(item);
    });
  }

  void _deleteItem(String name) {
    setState(() {
      _listItems.removeWhere((elem) => elem.name == name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The title text which will be shown on the action bar
          title: const Center(child: Text("Exam List")),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _addItemFunction(context),
            )
          ]),
      body: Center(
        child: _listItems.isEmpty
            ? const Text("No elements")
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: ListTile(
                      title: Text(
                        _listItems[index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: DateTimeText(_listItems[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteItem(_listItems[index].name),
                      ),
                    ),
                  );
                },
                itemCount: _listItems.length,
              ),
      ),
    );
  }
}
