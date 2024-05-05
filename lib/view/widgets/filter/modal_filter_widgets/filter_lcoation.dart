import 'package:flutter/material.dart';
import 'package:optomatica_race/view_model/races_view_model.dart';
import '../../../../model/filter_location_model.dart';

class FilterLocationWidget extends StatelessWidget {
  final List<SelectedLocationFilterRacesModel> selectedLocationFilterRacesModel;
  final RacesViewModel racesViewModel;
  const FilterLocationWidget({Key? key, required this.selectedLocationFilterRacesModel,required this.racesViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 1))),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: ListView.builder(
          itemCount: selectedLocationFilterRacesModel.length,
          itemBuilder: (context, index) => CheckboxListTile(
            title: Text(selectedLocationFilterRacesModel[index].filterLocationModel.countries),
            value: selectedLocationFilterRacesModel[index].selected,
            onChanged: (newValue) {
              racesViewModel.filterRacesByLocationFilter(selectedLocationFilterRacesModel[index],index);

            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
        ),
      ),
    );
  }
}
