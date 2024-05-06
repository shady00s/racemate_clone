import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optomatica_race/view_model/bloc/race_bloc.dart';
import 'package:optomatica_race/view_model/races_view_model.dart';

class FilterDateWidget extends StatefulWidget {
	final RacesViewModel racesViewModel;
	final RaceCubit raceCubit;

	const FilterDateWidget({Key? key, required this.racesViewModel, required this.raceCubit}) : super(key: key);

	@override
	State<FilterDateWidget> createState() => _DateTimeModalWidgetState();
}

class _DateTimeModalWidgetState extends State<FilterDateWidget> {
	DateTime? fromDate;
	DateTime? toDate;

	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text('From'),
				TextFormField(
					keyboardType: TextInputType.none,
					decoration: const InputDecoration(prefixIcon: Icon(Icons.date_range_rounded)),
					readOnly: true, // Make the field read-only
					onTap: () async {
						final selectedDate = await showDatePicker(
							context: context,
							firstDate: DateTime(DateTime.now().year - 3, 1, 1),
							lastDate: DateTime(DateTime.now().year + 3, 1, 1),
							initialDate: fromDate ?? DateTime.now(), // Set initial date
						);

						if (selectedDate != null) {
							setState(() {
								fromDate = selectedDate;
							});
							widget.racesViewModel.setStartDate(selectedDate);

						}
					},
					controller: TextEditingController(text: fromDate != null ? DateFormat('E, MMM d, yyyy').format(fromDate!) : ''), // Show selected date in the field
				),
				const Text('To'),
				TextFormField(
					keyboardType: TextInputType.none,
					decoration: const InputDecoration(prefixIcon: Icon(Icons.date_range_rounded)),
					readOnly: true, // Make the field read-only
					onTap: () async {
						final selectedDate = await showDatePicker(
							context: context,
							firstDate: DateTime(DateTime.now().year - 3, 1, 1),
							lastDate: DateTime(DateTime.now().year + 3, 1, 1),
							initialDate: toDate ?? DateTime.now(), // Set initial date
						);

						if (selectedDate != null) {
							setState(() {
								toDate = selectedDate;
							});
							widget.racesViewModel.setEndDate(selectedDate);

						}
					},
					controller: TextEditingController(text: toDate != null ? DateFormat('E, MMM d, yyyy').format(toDate!) : ''), // Show selected date in the field
				),
				SizedBox(height: 20,),
			],
		);
	}
}