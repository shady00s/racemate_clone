import 'package:flutter/material.dart';
import 'package:optomatica_race/view_model/bloc/race_bloc.dart';
import 'package:optomatica_race/view_model/races_view_model.dart';
import '../../../constants.dart';
import '../../../view_model/filter_view_model.dart';
import 'filter_modal.dart';
import 'modal_filter_widgets/clear_filter.dart';


class ClearFilterButton extends StatelessWidget {
  final RaceCubit raceCubit;
  final int numberOfFilters;
  final  RacesViewModel racesViewModel;
  const ClearFilterButton({super.key, required this.raceCubit, required this.numberOfFilters, required this.racesViewModel});

  @override
  Widget build(BuildContext context) {
    FilterButtonWidgetViewModel modal =   FilterButtonWidgetViewModel(filterTitle: 'Clear Filter', filterModalTitle: 'Clear Filter');

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
              // color:const Color.fromRGBO(28, 50, 95, 1),
              color: blueColor,
              borderRadius: BorderRadius.circular(8)),
          child: InkWell(
            onTap: () {
              showFilterModal(context,modal, ClearFilterWidget(racesViewModel:racesViewModel),const SizedBox(),null);
            },
            child:  SizedBox(
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
               const SizedBox(
                  width: 6,
                ),
                const  Image(
                  image: AssetImage('assets/images/filter.png'),
                ),
                const  SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: yellowColor,
                  child: Center(
                      child: Text(
                        numberOfFilters.toString(),
                    style:const TextStyle(color: blueColor),
                  )),
                )
              ]),
            ),
          )),
    );
  }
}
