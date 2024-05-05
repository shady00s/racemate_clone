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
  List<FilterTypeModel> selectedRaceTypeList = [];
  List<String> locationsList = [];
  List<String> typesList = [];
  DateTime? startDate;
  DateTime? endDate;
  int numberOfFilters = 1;

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
    } catch (err) {
      emit(FetchingFailedState(error: err.toString()));
    }
  }

  // initialize  data from JSON and set the filters
  Future<void> fetchData() async {
    try {
      await getDataFromJson();
      //setting filters data
      getAllLocationsFilter();
      getAllTypesFilter();
      emit(FetchingSuccessState(listOfRaces, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters));
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
    countryCount.forEach((key, value) {
      selectedLocationFilterRacesModel.add(SelectedLocationFilterRacesModel(
          selected: true,
          filterLocationModel: FilterLocationModel(
            countries: '${value['name']} (${value['number']})',
          ),
          racesDataModel: value['data']));
    });
  }

  //getting all race types
  void getAllTypesFilter() {
    Map<String, dynamic> typeCount = {};
    for (var e in listOfRaces) {
      if (typeCount[e.type] == null) {
        typeCount[e.type] = {
          'name': e.type,
        };
      }
    }
    List<FilterTypeModel> list = [];
    typeCount.forEach((key, value) {
      list.add(FilterTypeModel(type: value['name'], groupValue: null));
    });
    selectedRaceTypeList = list;
  }

  Future<void> clearAllFilters() async {
    await getDataFromJson();
    numberOfFilters = 0;
    resetSelectLocations();
  }

  void updateFilterNumber() {}

  // Set new selected races based on location filter
  void filterLocationListGetter(SelectedLocationFilterRacesModel data, int index, selected) {
    SelectedLocationFilterRacesModel newSelectedLocationFilterRacesModel = SelectedLocationFilterRacesModel(selected: selected, filterLocationModel: data.filterLocationModel, racesDataModel: data.racesDataModel);

    List<SelectedLocationFilterRacesModel> updatedSelectedLocationFilterRacesModel = List.from(selectedLocationFilterRacesModel);
    updatedSelectedLocationFilterRacesModel[index] = newSelectedLocationFilterRacesModel;
    selectedLocationFilterRacesModel = updatedSelectedLocationFilterRacesModel;

    if (newSelectedLocationFilterRacesModel.selected == true && !locationsList.contains(newSelectedLocationFilterRacesModel.racesDataModel.country)) {
      locationsList.add(newSelectedLocationFilterRacesModel.racesDataModel.country);
    } // to remove the unselected locations
    else if (newSelectedLocationFilterRacesModel.selected == false && locationsList.contains(newSelectedLocationFilterRacesModel.racesDataModel.country)) {
      locationsList.remove(newSelectedLocationFilterRacesModel.racesDataModel.country);
    }
    filterDistanceListGetter();
    emit(FetchingSuccessState(listOfRaces, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters));
  }

  // Set new selected races based on distance filter
  void filterTypeListGetter(String value, int index, String? newValue) {
    FilterTypeModel newFilterType = FilterTypeModel(type: value, groupValue: newValue);

    // Ensure index is within bounds
    if (index >= 0 && index < selectedRaceTypeList.length) {
      List<FilterTypeModel> updatedSelectedRaceTypeList = List.from(selectedRaceTypeList);
      updatedSelectedRaceTypeList[index] = newFilterType;
      selectedRaceTypeList = updatedSelectedRaceTypeList;

      // Update typesList based on selection
      if (newFilterType.groupValue == null && !typesList.contains(newFilterType.type)) {
        typesList.add(newFilterType.type);
      } else if (newFilterType.groupValue != null && typesList.contains(newFilterType.type)) {
        typesList.remove(newFilterType.type);
      }

      // Consider emitting state here or based on your application logic
      emit(FetchingSuccessState(listOfRaces, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters));
    }
  }

  // Set new selected races based on distance filter
  void filterDistanceListGetter() {
    if (locationsList.isNotEmpty) {
      numberOfFilters + 1;
    }
    if (typesList.isNotEmpty) {
      numberOfFilters + 1;
    }
  }

// reset all filter locations to true (default)
  void resetSelectLocations() {
    for (var model in selectedLocationFilterRacesModel) {
      model.selected = true;
    }
    emit(FetchingSuccessState(listOfRaces, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters));
  }

  void resetSelectDistance() {
    // for (var model in selectedLocationFilterRacesModel) {
    //   model.selected = false;
    // }
    // emit(FetchingSuccessState(listOfRaces,selectedLocationFilterRacesModel,raceTypeList));
  }

  void resetSelectTypes() {
    // for (var model in selectedLocationFilterRacesModel) {
    //   model.selected = false;
    // }
    // emit(FetchingSuccessState(listOfRaces,selectedLocationFilterRacesModel,raceTypeList));
  }

  // re-fetch data from json by the filter options
  Future<void> submitFilterData() async {
    // to re-fetch data from json
    await getDataFromJson();
    List<RacesDataModel> filteredLocationRaces = List.from(listOfRaces);
    if (locationsList.isNotEmpty) {
      filteredLocationRaces = listOfRaces.where((element) => locationsList.contains(element.country)).toList();
    }
    if (typesList.isNotEmpty) {
      filteredLocationRaces = listOfRaces.where((element) => typesList.contains(element.type)).toList();
    }
    emit(FetchingSuccessState(filteredLocationRaces, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters));
  }
}
