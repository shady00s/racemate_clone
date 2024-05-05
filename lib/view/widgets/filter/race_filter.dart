import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_race/view_model/bloc/states/race_state.dart';
import 'package:optomatica_race/view_model/races_view_model.dart';
import '../../../view_model/bloc/race_bloc.dart';
import 'clear_filter_button.dart';
import 'filter_modal.dart';
import '../../../view_model/filter_view_model.dart';
import 'modal_filter_widgets/filter_lcoation.dart';

class RacesFilterWidget extends StatelessWidget {
    final RacesViewModel racesViewModel;

    RacesFilterWidget({Key? key, required this.racesViewModel}) : super(key: key);

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
                               const SizedBox(
                                    width: 63,
                                    height: 45,
                                    child: ClearFilterButton(),
                                ),
                                Expanded(
                                    child: ListView(
                                        children: [
                                            FilterButtonWidget(
                                                modal: racesViewModel.locationFilter,
                                                widget: FilterLocationWidget(
                                                    racesViewModel:racesViewModel,
                                                    selectedLocationFilterRacesModel: state.selectedLocationFilterRacesModel,
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            ],
                        ),
                    );
                } else {
                    return SizedBox(); // Return an empty widget or loading indicator if needed
                }
            },
        );
    }
}


class FilterButtonWidget extends StatelessWidget {
  final FilterButtonWidgetViewModel modal;
  final Widget widget;
  const FilterButtonWidget({super.key, required this.modal, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
              // color:const Color.fromRGBO(28, 50, 95, 1),
              border: Border.all(style: BorderStyle.solid, color: const Color.fromRGBO(28, 50, 95, 1)),
              borderRadius: BorderRadius.circular(8)),
          child: InkWell(
            onTap: () {
              showFilterModal(context, modal,widget);
            },
            child: SizedBox(
              child: Row(children: [
                const SizedBox(
                  width: 12,
                ),
                Text(modal.filterTitle),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color.fromRGBO(28, 50, 95, 1),
                )
              ]),
            ),
          )),
    );
  }
}
