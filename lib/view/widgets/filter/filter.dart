import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../model/filter_button_widget.dart';
import 'clear_filter_button.dart';
import 'filter_modal.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          children: [
           const SizedBox(
              width: 63,
              height: 45,
              child: ClearFilterButton(),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterWidgetsList.length,
                  itemBuilder: (context, index) => FilterButtonWidget(
                        modal: filterWidgetsList[index],
                      )),
            ),
          ],
        ));
  }
}

class FilterButtonWidget extends StatelessWidget {
  final FilterButtonWidgetModel modal;

  const FilterButtonWidget({super.key, required this.modal});

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
              showFilterModal(context, modal);
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
