import 'package:flutter/material.dart';
import '../../../model/filter_button_widget.dart';

Future<void> showFilterModal(
	BuildContext context,
	FilterButtonWidgetModel model
	) async {
	return await showModalBottomSheet(
		context: context,
		builder: (context) => Card(
			child: Column(
				mainAxisSize: MainAxisSize.min,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: [
					const  SizedBox(
						width: 80,
						height: 10,
						child: Card(
							color: Color.fromRGBO(205, 211, 228, 1),
						)),
					const   SizedBox(
						height: 15,
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							const  Expanded(flex: 1, child: SizedBox()),
							Expanded(
								flex: 3,
								child: Text(
									model.filterModalTitle,
									textAlign: TextAlign.center,
									style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
								)),
							Expanded(
								flex: 1,
								child: TextButton(
									onPressed: () {},
									child:const Text(
										'RESET',
										style: TextStyle(color: Color.fromRGBO(189, 80, 0, 1)),
									)))
						],
					),
					model.filterComponents

				],
			),
		));
}
