import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_race/view_model/bloc/states/race_state.dart';
import 'package:optomatica_race/view_model/races_view_model.dart';
import '../../../../view_model/bloc/race_bloc.dart';

class FilterTypeWidget extends StatelessWidget {
  final RaceCubit raceCubit;
  final RacesViewModel racesViewModel;
  const FilterTypeWidget({Key? key, required this.racesViewModel, required this.raceCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: raceCubit,
        builder: (context, state) {
          if (state is FetchingSuccessState) {
            return DecoratedBox(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 1))),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: state.selectedFilterTypeModel.length,
                  itemBuilder: (context, index) => RadioListTile(
                    title: Text(state.selectedFilterTypeModel[index].type),
                    value: state.selectedFilterTypeModel[index].type,
                    onChanged: (newValue) {
                      racesViewModel.filterTypeListGetter(state.selectedFilterTypeModel[index].type, index, newValue);
                    },
                    controlAffinity: ListTileControlAffinity.trailing, groupValue: state.selectedFilterTypeModel[index].groupValue,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        });
  }
}
