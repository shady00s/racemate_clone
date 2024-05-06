import 'package:flutter/material.dart';
import 'package:optomatica_race/view/widgets/filter/filter_submit_button.dart';
import 'package:optomatica_race/view_model/races_view_model.dart';

import '../filter_cancel_button.dart';

class ClearFilterWidget extends StatelessWidget {
  final RacesViewModel racesViewModel;
  const ClearFilterWidget({super.key, required this.racesViewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 10,),
        SubmitFilterButton(
            onPressed: () {
              Future.microtask(() => racesViewModel.clearAllFilters()).then((value) => Navigator.pop(context));
              },
            title: 'Yes, Clear Filters'),
		const SizedBox(height: 10,),
        CancelFilterButton(
          onPressed: () {Navigator.pop(context);},
          title: 'Cancel',
        ),
		  const SizedBox(height: 10,),

	  ],
    );
  }
}
