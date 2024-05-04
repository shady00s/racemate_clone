import 'package:flutter/material.dart';


class FilterLocationWidget extends StatefulWidget {
  const FilterLocationWidget({super.key});

  @override
  State<FilterLocationWidget> createState() => _FilterLocationWidgetState();
}

class _FilterLocationWidgetState extends State<FilterLocationWidget> {
	bool checkedValue=false;

	@override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
        		decoration:const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey,style: BorderStyle.solid ,width: 1))),
          child: CheckboxListTile(
          		title:const Text("title text"),
          		value: checkedValue,
          		onChanged: (newValue) {
          			setState(() {
          				checkedValue = newValue!;
          			});
          		},
          		controlAffinity: ListTileControlAffinity.trailing,
          	),
        ),
      ],
    );
  }
}


