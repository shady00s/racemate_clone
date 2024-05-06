import 'package:optomatica_race/view_model/bloc/race_bloc.dart';
import '../model/filter_location_model.dart';
import '../model/races_model.dart';
import 'filter_view_model.dart';

class RacesViewModel {
  final RaceCubit raceCubit = RaceCubit();

  List<RacesDataModel> getRacesList() {
    return raceCubit.listOfRaces;
  }

  Future<void> fetchData() async {
    return await raceCubit.fetchData();
  }

  Future<void> getDataFromJsonByLimit() async {
    return await raceCubit.getDataFromJsonByLimit();
  }

  Future<void> getMoreDataFromJSON() async {
    return await raceCubit.getMoreDataFromJSON();
  }

  void filterLocationListGetter(SelectedLocationFilterRacesModel value, int index, selected) {
    raceCubit.filterLocationListGetter(value, index, selected);
  }

  void filterTypeListGetter(String value, int index, newValue) {
    raceCubit.filterTypeListGetter(value, index, newValue);
  }

  void clearAllFilters() {
    raceCubit.clearAllFilters();
  }

  void resetSelectLocations() {
    raceCubit.resetSelectLocations();
  }

  void resetSelectTypes() {
    raceCubit.resetSelectLocations();
  }

  void resetSelectDistance() {
    raceCubit.resetSelectDistance();
  }

  void setDistance(int number) {
    raceCubit.setDistance(number);
  }

  Future<void> submitFilterData() async {
    await raceCubit.submitFilterData();
  }

  void locationsSearch(String search) {
    raceCubit.locationsSearch(search);
  }

  void racesSearch(String search) {
    raceCubit.racesSearch(search);
  }
  void setStartDate(DateTime? startDate) {
    raceCubit.setStartDate(startDate);
  }
  void setEndDate(DateTime? endDate) {
    raceCubit.setEndDate(endDate);
  }

  FilterButtonWidgetViewModel locationFilter = FilterButtonWidgetViewModel(filterTitle: 'Location', filterModalTitle: 'RACE LOCATION');
  FilterButtonWidgetViewModel typeFilter = FilterButtonWidgetViewModel(
    filterTitle: 'Type',
    filterModalTitle: 'RACE TYPE',
  );

  FilterButtonWidgetViewModel dateFilter = FilterButtonWidgetViewModel(filterTitle: 'Date', filterModalTitle: 'RACE DATE');

  FilterButtonWidgetViewModel distanceFilter = FilterButtonWidgetViewModel(filterTitle: 'Distance', filterModalTitle: 'RACE DISTANCE');
}
