import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_race/view_model/bloc/states/race_state.dart';
import 'package:optomatica_race/view_model/races_view_model.dart';
import '../../../../view_model/bloc/race_bloc.dart';

class FilterDistanceWidget extends StatelessWidget {
	final RaceCubit raceCubit;
	final RacesViewModel racesViewModel;
	const FilterDistanceWidget({Key? key, required this.racesViewModel, required this.raceCubit}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return BlocBuilder(
			bloc: raceCubit,
			builder: (context, state) {
				if (state is FetchingSuccessState){
					return DecoratedBox(
						decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, style: BorderStyle.solid, width: 1))),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
						  children: [
							  Padding(
							    padding: const EdgeInsets.only(left: 10.0),
							    child: Text('${state.distance}K - 45K'),
							  ),
						    SizedBox(
						    	height: MediaQuery.of(context).size.height * 0.15,
						    	child: Slider(min: 0,max:45, value: state.distance.toDouble(), onChanged: (change){
									racesViewModel.setDistance( change.toInt())	;
						    	})
						    ),
						  ],
						),
					);
				}else{
					return const SizedBox();
				}
			}
		);
	}
}
