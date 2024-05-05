import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_race/view/widgets/filter/modal_filter_widgets/type_filter.dart';
import 'package:optomatica_race/view_model/bloc/states/race_state.dart';
import 'package:optomatica_race/view_model/races_view_model.dart';
import '../../../view_model/bloc/race_bloc.dart';
import 'clear_filter_button.dart';
import 'filter_button.dart';
import 'filter_submit_button.dart';
import 'modal_filter_widgets/distance_filter.dart';
import 'modal_filter_widgets/location_filter.dart';

class RacesFilterWidget extends StatelessWidget {
  final RacesViewModel racesViewModel;

  const RacesFilterWidget({Key? key, required this.racesViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RaceCubit, RaceState>(
      builder: (context, state) {
        if (state is FetchingSuccessState) {
          return SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                state.numberOfFilters > 0
                    ? SizedBox(
                        width: 63,
                        height: 42,
                        child: ClearFilterButton(
                          racesViewModel: racesViewModel,

                          numberOfFilters:state.numberOfFilters,
                          raceCubit: context.read<RaceCubit>(),
                        ),
                      )
                    : const SizedBox(),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FilterButtonWidget(
                        hasActiveFilters: true,
                        modal: racesViewModel.locationFilter,
                        widget: FilterLocationWidget(
                          racesViewModel: racesViewModel,
                          // selectedLocationFilterRacesModel: state.selectedLocationFilterRacesModel,
                          raceCubit: context.read<RaceCubit>(),
                        ),
                        onCancel: racesViewModel.resetSelectLocations,
                        bottomWidget: SubmitFilterButton(
                          onPressed: () {
                            racesViewModel.submitFilterData();
                          },
                          title: '',
                        ),
                      ),
                      FilterButtonWidget(
                        modal: racesViewModel.typeFilter,
                        widget: FilterTypeWidget(racesViewModel: racesViewModel, raceCubit: context.read<RaceCubit>()),
                        onCancel: racesViewModel.resetSelectLocations,
                        bottomWidget: SubmitFilterButton(
                          onPressed: () {},
                          title: '',
                        ),
                        hasActiveFilters: true,
                      ),
                      FilterButtonWidget(
                        hasActiveFilters: true,
                        modal: racesViewModel.distanceFilter,
                        widget: FilterDistanceWidget(racesViewModel: racesViewModel, raceCubit: context.read<RaceCubit>()),
                        onCancel: racesViewModel.resetSelectLocations,
                        bottomWidget: SubmitFilterButton(
                          onPressed: () {},
                          title: '',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox(); // Return an empty widget or loading indicator if needed
        }
      },
    );
  }
}
