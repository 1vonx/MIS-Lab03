import 'package:flutter/cupertino.dart';
import 'package:lab_03/model/exam_list_item.dart';

class DateTimeText extends StatelessWidget {
  final ExamListItem listItem;

  const DateTimeText(this.listItem, {super.key});

  bool _checkIfSingleDigit(int value){
    if(value/10<1) {
      return false;
    }

    return true;
  }

  String _getText(){
    String dayText;
    String monthText;
    String hourText;
    String minText;
    String finalText;

    dayText = _checkIfSingleDigit(listItem.dateTime.day) ? "${listItem.dateTime.day}" : "0${listItem.dateTime.day}";
    monthText = _checkIfSingleDigit(listItem.dateTime.month) ? "${listItem.dateTime.month}" : "0${listItem.dateTime.month}";
    hourText = _checkIfSingleDigit(listItem.dateTime.hour) ? "${listItem.dateTime.hour}" : "0${listItem.dateTime.hour}";
    minText = _checkIfSingleDigit(listItem.dateTime.minute) ? "${listItem.dateTime.minute}" : "0${listItem.dateTime.minute}";
    finalText = "$dayText.$monthText.${listItem.dateTime.year} $hourText:$minText";

    return finalText;
  }

  @override
  Widget build(BuildContext context) {
    return Text(_getText());
  }
}