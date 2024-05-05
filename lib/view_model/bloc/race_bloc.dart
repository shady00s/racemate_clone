import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_race/view_model/bloc/states/race_state.dart';

import '../../model/filter_location_model.dart';
import '../../model/races_model.dart';

class RaceCubit extends Cubit<RaceState> {
  RaceCubit() : super(InitState());
  List<RacesDataModel> listOfRaces = [];
  List<SelectedLocationFilterRacesModel> selectedLocationFilterRacesModel = [];

  // Fetching data from JSON
  Future<void> getDataFromJson() async {
    try {
      final String response = await rootBundle.loadString('assets/races_data.json');
      await Future.delayed(const Duration(seconds: 1)); // Simulate delay
      final List<dynamic> jsonData = json.decode(response);
      List<RacesDataModel> data = jsonData.map((jsonItem) {
        return RacesDataModel.fromJson(jsonItem);
      }).toList();
      listOfRaces = data;
      getAllLocationsFilter();
      emit(FetchingSuccessState(data, selectedLocationFilterRacesModel));
    } catch (err) {
      emit(FetchingFailedState(error: err.toString()));
    }
  }

  //getting all countries with number of races
  void getAllLocationsFilter() {
    Map<String, dynamic> countryCount = {};
    for (var e in listOfRaces) {
      if (countryCount[e.country] == null) {
        countryCount[e.country] = {'name': e.country, 'number': 1, 'data': e};
      } else {
        countryCount[e.country]['number'] += 1;
      }
    }
    List<SelectedLocationFilterRacesModel> list = [];
    countryCount.forEach((key, value) {
      list.add(SelectedLocationFilterRacesModel(
          selected: false,
          filterLocationModel: FilterLocationModel(
            countries: '${value['name']} (${value['number']})',
          ),
          racesDataModel: value['data']));
    });
    selectedLocationFilterRacesModel = list;
  }

  // Set new selected races based on location filter
  void filterRacesByLocationFilter(SelectedLocationFilterRacesModel data, int index) {
    // Filter races based on selected location
    List<RacesDataModel> filteredRaces = listOfRaces.where((element) => element.country == data.racesDataModel.country).toList();
    SelectedLocationFilterRacesModel newSelectedLocationFilterRacesModel = SelectedLocationFilterRacesModel(selected: !data.selected, filterLocationModel: data.filterLocationModel, racesDataModel: data.racesDataModel);
    List<SelectedLocationFilterRacesModel> updatedSelectedLocationFilterRacesModel = List.from(selectedLocationFilterRacesModel);
    updatedSelectedLocationFilterRacesModel[index] = newSelectedLocationFilterRacesModel;
    emit(FetchingSuccessState(filteredRaces, updatedSelectedLocationFilterRacesModel));
  }
}
