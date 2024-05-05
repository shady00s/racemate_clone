import 'package:flutter/material.dart';
import '../../../view_model/filter_view_model.dart';
import 'filter_modal.dart';

class FilterButtonWidget extends StatelessWidget {
	final FilterButtonWidgetViewModel modal;
	final Widget widget;
	final Widget bottomWidget;
	final Function onCancel;
	final bool hasActiveFilters;
	const FilterButtonWidget({super.key,required this.hasActiveFilters, required this.modal, required this.widget,required this.onCancel, required this.bottomWidget});

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
						showFilterModal(context, modal, widget,bottomWidget ,onCancel);
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