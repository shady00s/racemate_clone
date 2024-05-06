import 'package:flutter/material.dart';
import 'package:optomatica_race/constants.dart';
import 'package:optomatica_race/view_model/bloc/race_bloc.dart';
import '../../../view_model/filter_view_model.dart';
import 'filter_modal.dart';

class FilterButtonWidget extends StatelessWidget {
	final FilterButtonWidgetViewModel modal;
	final bool selected;
	final Widget widget;
	final Widget bottomWidget;
	final Function onCancel;
	final bool hasActiveFilters;
	const FilterButtonWidget({super.key,required this.hasActiveFilters,required this.selected, required this.modal, required this.widget,required this.onCancel, required this.bottomWidget});

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.all(8.0),
			child: DecoratedBox(
				decoration: BoxDecoration(

					  color: selected ? blueColor:whiteBackground,

					border: Border.all(style: BorderStyle.solid, color: const Color.fromRGBO(28, 50, 95, 1)),
					borderRadius: BorderRadius.circular(8)),
				child: InkWell(
					onTap: () {
						showFilterModal(context, modal, widget,bottomWidget ,onCancel);
					},
					child: SizedBox(
						child: Row(children: [
							const SizedBox(
								width: 12,
							),
							Text(modal.filterTitle,style: TextStyle(color:selected ?  whiteBackground:blueColor,),),
							 Icon(
								Icons.keyboard_arrow_down_rounded,
								color: selected ?  whiteBackground:blueColor,
							)
						]),
					),
				)),
		);
	}
}