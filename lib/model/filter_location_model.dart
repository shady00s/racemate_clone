import 'package:optomatica_race/model/races_model.dart';

class FilterModel {
  final List<String> races;
  final List<String> countries;
  FilterModel({required this.races, required this.countries});
}

class FilterLocationModel {
  final String countries;
  FilterLocationModel({required this.countries});
}


class SelectedLocationFilterRacesModel{
   bool selected;
 final FilterLocationModel filterLocationModel;
 final RacesDataModel racesDataModel;

  SelectedLocationFilterRacesModel( {required this.racesDataModel,required this.selected, required this.filterLocationModel});
}

class FilterTypeModel{
    final String type;
    FilterTypeModel({required this.type});

}

class FilterDistanceModel{
    final String distance;
    FilterDistanceModel({required this.distance});

}