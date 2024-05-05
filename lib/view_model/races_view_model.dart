import 'package:optomatica_race/view_model/bloc/race_bloc.dart';
import '../model/filter_location_model.dart';
import '../model/races_model.dart';
import 'filter_view_model.dart';

class RacesViewModel {
  final RaceCubit raceCubit = RaceCubit();

  List<RacesDataModel> getRacesList() {
    return raceCubit.listOfRaces;
  }

  Future<void> getDataFromJson() async {
    return await raceCubit.getDataFromJson();
  }

  void filterRacesByLocationFilter(SelectedLocationFilterRacesModel value,int index){
      raceCubit.filterRacesByLocationFilter(value,index);
  }

  FilterButtonWidgetViewModel locationFilter = FilterButtonWidgetViewModel(filterTitle: 'Location', filterModalTitle: 'Race Location', submitOnClick: () {});

}
