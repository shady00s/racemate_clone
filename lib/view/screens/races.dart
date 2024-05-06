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
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  @override
  void initState() {
    racesViewModel.getDataFromJsonByLimit();
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // User has scrolled to the bottom
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      racesViewModel.getMoreDataFromJSON().then((_){
        setState(() {
          _isLoading = false;
        });
      });

    }
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
                      SearchWidget(
                        racesViewModel: racesViewModel,
                      ),
                      RacesFilterWidget(
                        racesViewModel: racesViewModel,
                      ),
                    state.listOfRaces.isNotEmpty?
                      Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: state.listOfRaces.length,
                            itemBuilder: (builder, index) => RaceCardWidget(
                              raceData: state.listOfRaces[index],
                            ),
                          )
                      ):Center(child: Text('No races found')),
                      _isLoading? const SizedBox(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator(),),
                      ),) :const SizedBox()
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
