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

  void filterLocationListGetter(SelectedLocationFilterRacesModel value, int index, selected) {
    raceCubit.filterLocationListGetter(value, index, selected);
  }

  void filterTypeListGetter(String value, int index,newValue) {
    raceCubit.filterTypeListGetter(value, index,newValue);
  }
  void clearAllFilters (){
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

  void submitFilterData() {
    raceCubit.submitFilterData();
  }

  FilterButtonWidgetViewModel locationFilter = FilterButtonWidgetViewModel(filterTitle: 'Location', filterModalTitle: 'Race Location');
  FilterButtonWidgetViewModel typeFilter = FilterButtonWidgetViewModel(
    filterTitle: 'Type',
    filterModalTitle: 'Race Type',
  );
  FilterButtonWidgetViewModel distanceFilter = FilterButtonWidgetViewModel(filterTitle: 'Distance', filterModalTitle: 'Race Distance');
}
