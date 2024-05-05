import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_race/view_model/bloc/states/race_state.dart';
import 'package:optomatica_race/view_model/races_view_model.dart';
import '../../../../model/filter_location_model.dart';
import '../../../../view_model/bloc/race_bloc.dart';

class FilterLocationWidget extends StatelessWidget {
  final RaceCubit raceCubit;
  final RacesViewModel racesViewModel;
  const FilterLocationWidget({Key? key, required this.racesViewModel, required this.raceCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: raceCubit,
        builder: (context, state) {
          if (state is FetchingSuccessState) {
            return DecoratedBox(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 1))),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  shrinkWrap: false,
                  itemCount: state.selectedLocationFilterRacesModel.length,
                  itemBuilder: (context, index) => CheckboxListTile(
                    selected: state.selectedLocationFilterRacesModel[index].selected,
                    title: Text(state.selectedLocationFilterRacesModel[index].filterLocationModel.countries),
                    value: state.selectedLocationFilterRacesModel[index].selected,
                    onChanged: (newValue) {
                      racesViewModel.filterRacesByLocationFilter(state.selectedLocationFilterRacesModel[index], index, newValue);
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        });
  }
}
