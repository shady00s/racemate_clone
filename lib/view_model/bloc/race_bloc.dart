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
  Map<String,int> filtersUsed ={};
  int numberOfFilters = 1;
  int distance = 0;
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

  //fetching data by limit
  Future<void> getDataFromJsonByLimit() async {
    try {
      final String response = await rootBundle.loadString('assets/races_data.json');
      await Future.delayed(const Duration(seconds: 1)); // Simulate delay
      final List<dynamic> jsonData = json.decode(response);
      final List<dynamic> first10JsonData = jsonData.take(10).toList();

      List<RacesDataModel> data = first10JsonData.map((jsonItem) {
        return RacesDataModel.fromJson(jsonItem);
      }).toList();
      listOfRaces = data;
      await fetchData();
      emit(FetchingSuccessState(listOfRaces, distance, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters,filtersUsed));
    } catch (err) {
      emit(FetchingFailedState(error: err.toString()));
    }
  }

  Future<void> getMoreDataFromJSON() async {
    try {
      final String response = await rootBundle.loadString('assets/races_data.json');
      await Future.delayed(const Duration(seconds: 1)); // Simulate delay
      final List<dynamic> jsonData = json.decode(response);

      // Get the next 10 items to load
      final List<dynamic> next10JsonData = jsonData.skip(listOfRaces.length).take(10).toList();

      List<RacesDataModel> data = next10JsonData.map((jsonItem) {
        return RacesDataModel.fromJson(jsonItem);
      }).toList();

      // Add the new data to the existing list
      listOfRaces.addAll(data);

      emit(FetchingSuccessState(listOfRaces, distance, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters,filtersUsed));
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
        locationsList.add(e.country);
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
    filtersUsed['location'] = 1; // Update filter status

  }

  void locationsSearch(String search) {
    if (search != '') {
      List<SelectedLocationFilterRacesModel> newSelectedLocationFilterRacesModel = List.from(selectedLocationFilterRacesModel);
      List<SelectedLocationFilterRacesModel> updatedList = newSelectedLocationFilterRacesModel.where((element) => element.racesDataModel.country.contains(search.trim())).toList();
      emit(FetchingSuccessState(listOfRaces, distance, updatedList, selectedRaceTypeList, numberOfFilters,filtersUsed));
    }
  }

  void racesSearch(String search) {
    if (search != '') {
      List<RacesDataModel> newListOfRaces = List.from(listOfRaces);
      List<RacesDataModel> updatedList = newListOfRaces.where((element) => element.country.contains(search.trim()) || element.name.contains(search.trim())).toList();
      emit(FetchingSuccessState(updatedList, distance, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters,filtersUsed));
    }
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
    await fetchData();
    numberOfFilters = 0;
    resetSelectLocations();
    resetSelectDistance();
  }

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
    emit(FetchingSuccessState(listOfRaces, distance, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters,filtersUsed));
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
      emit(FetchingSuccessState(listOfRaces, distance, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters,filtersUsed));
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

  void setDistance(int number) {
    distance = number;
    emit(FetchingSuccessState(listOfRaces, distance, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters,filtersUsed));
  }

// reset all filter locations to true (default)
  void resetSelectLocations() {
    for (var model in selectedLocationFilterRacesModel) {
      model.selected = true;
    }
    emit(FetchingSuccessState(listOfRaces, distance, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters,filtersUsed));
  }

  void resetSelectDistance() {
    distance = 0;
    emit(FetchingSuccessState(listOfRaces, distance, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters,filtersUsed));
  }

  void resetSelectTypes() {
    // emit(FetchingSuccessState(listOfRaces,selectedLocationFilterRacesModel,raceTypeList));
  }

  void setStartDate(DateTime? startDate1){
    startDate = startDate1;
  }
  void setEndDate(DateTime? endDate1){
    endDate = endDate1;
  }
  // re-fetch data from json by the filter options
  Future<void> submitFilterData() async {
    // to re-fetch data from json
    await getDataFromJson();
    List<RacesDataModel> filteredLocationRaces = List.from(listOfRaces);
    if (locationsList.isNotEmpty) {
      filteredLocationRaces = listOfRaces.where((element) => locationsList.contains(element.country)).toList();
      filtersUsed['location'] = 1; // Update filter status

    }
    if (typesList.isNotEmpty) {
      filteredLocationRaces = listOfRaces.where((element) => typesList.contains(element.type)).toList();
      filtersUsed['types'] = 1; // Update filter status

    }
    if (distance > 0) {
      filteredLocationRaces = listOfRaces.where((e) {
        List<double> distances = e.distances.split('K, ').map((double.parse)).toList();
        return distances.any((distanceFromItems) => distanceFromItems.toInt() == distance);
      }).toList();
      // filteredLocationRaces = listOfRaces.where((element) => element.)
      filtersUsed['distance'] = 1; // Update filter status

    }
    if(startDate != null && endDate !=null){
      filtersUsed['date'] = 1; // Update filter status
      filteredLocationRaces = listOfRaces.where((element) {
        DateTime raceDate = DateTime.parse(element.date); // Convert race date string to DateTime
        return raceDate.isAfter(startDate!) && raceDate.isBefore(endDate!);
      }).toList();
    }
    numberOfFilters = filtersUsed.length;
    emit(FetchingSuccessState(filteredLocationRaces, distance, selectedLocationFilterRacesModel, selectedRaceTypeList, numberOfFilters,filtersUsed));
  }
}
