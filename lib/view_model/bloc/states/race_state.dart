import '../../../model/filter_location_model.dart';
import '../../../model/races_model.dart';

abstract class RaceState {}

class InitState extends RaceState {}

class FetchingSuccessState extends RaceState {
	final List<RacesDataModel> listOfRaces;
	final List<SelectedLocationFilterRacesModel>selectedLocationFilterRacesModel;
	final List<FilterTypeModel>selectedFilterTypeModel;
	final int numberOfFilters;
	final int distance;
	final Map<String,int> filtersUsed;
	FetchingSuccessState(this.listOfRaces,this.distance, this.selectedLocationFilterRacesModel, this.selectedFilterTypeModel, this.numberOfFilters,this.filtersUsed);
}

class FetchingFailedState extends RaceState {
	final String error;
	FetchingFailedState({required this.error});
}


