import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lab_03/model/exam_list_item.dart';

class NewItem extends StatefulWidget {
  final Function addItem;

  const NewItem(this.addItem, {super.key});
  @override
  State<StatefulWidget> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();

  late String name;
  late DateTime dateTime;

  void _submitData() {
    if (_dateController.text.isEmpty) {
      return;
    }
    final enteredName = _nameController.text;
    final enteredDateTime = DateTime.parse(_dateController.text);

    if (enteredName.isEmpty) {
      return;
    }

    final newItem = ExamListItem(name: enteredName, dateTime: enteredDateTime);
    widget.addItem(newItem);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name"),
            onSubmitted: (_) => _submitData(),
          ),
          DateTimeField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: "Date"),
              format: DateFormat("yyyy-MM-dd HH:mm"),
              onShowPicker: (BuildContext context, DateTime? currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));

                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
            onFieldSubmitted: (_) => _submitData(),
          ),
          ElevatedButton(
            child: const Text("Add"),
            onPressed: () => _submitData(),
          ),
        ],
      ),
    );
  }
}
