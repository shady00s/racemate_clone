import 'package:flutter/material.dart';

class DateTimeModalWidget extends StatefulWidget {
  const DateTimeModalWidget({super.key});

  @override
  State<DateTimeModalWidget> createState() => _DateTimeModalWidgetState();
}

class _DateTimeModalWidgetState extends State<DateTimeModalWidget> {

  @override
  Widget build(BuildContext context) {
    return  Column(
		children: [
			Text('From'),
			TextFormField(  keyboardType: TextInputType.none, decoration: InputDecoration(),onTap: (){
				showDatePicker(context: context,
					firstDate: DateTime(DateTime.now().year - 3, 1, 1),
					lastDate:  DateTime(DateTime.now().year + 3, 1, 1),);
			},),
			Text('To'),
			TextFormField(decoration: InputDecoration(),)
		],
	);
  }
}
