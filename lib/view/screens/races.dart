import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_race/view/widgets/race_card.dart';
import 'package:optomatica_race/view_model/bloc/race_bloc.dart';
import 'package:optomatica_race/view_model/bloc/states/race_state.dart';
import '../../view_model/races_view_model.dart';
import '../widgets/filter/race_filter.dart';
import '../widgets/search_widget.dart';

class RacesView extends StatefulWidget {
  const RacesView({Key? key}) : super(key: key);
  @override
  State<RacesView> createState() => _RacesViewState();
}
class _RacesViewState extends State<RacesView> {
  final RacesViewModel racesViewModel = RacesViewModel();
    @override
  void initState() {
        racesViewModel.fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RaceCubit>.value(
        value: racesViewModel.raceCubit,

      child: BlocBuilder<RaceCubit, RaceState>(
        builder: (context, state) {
          print(state);
          if (state is FetchingSuccessState) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                    const SearchWidget(),
                     RacesFilterWidget(racesViewModel: racesViewModel,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.listOfRaces.length,
                      itemBuilder: (builder, index) => RaceCardWidget(
                        raceData: state.listOfRaces[index],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is FetchingFailedState) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
































