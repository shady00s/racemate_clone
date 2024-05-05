import '../../../model/filter_location_model.dart';
import '../../../model/races_model.dart';

abstract class RaceState {}

class InitState extends RaceState {}

class FetchingSuccessState extends RaceState {
	final List<RacesDataModel> listOfRaces;
	final List<SelectedLocationFilterRacesModel>selectedLocationFilterRacesModel;
	FetchingSuccessState(this.listOfRaces, this.selectedLocationFilterRacesModel);
}

class FetchingFailedState extends RaceState {
	final String error;
	FetchingFailedState({required this.error});
}


