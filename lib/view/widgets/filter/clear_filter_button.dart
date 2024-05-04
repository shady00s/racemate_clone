import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../model/filter_button_widget.dart';
import 'filter_modal.dart';
import 'modal_filter_widgets/clear_filter.dart';


class ClearFilterButton extends StatelessWidget {
  const ClearFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    FilterButtonWidgetModel modal =   FilterButtonWidgetModel(filterComponents: const ClearFilterWidget(), filterTitle: 'Clear Filter', filterModalTitle: 'Clear Filter', submitOnClick: () {});

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DecoratedBox(
          decoration: BoxDecoration(
              // color:const Color.fromRGBO(28, 50, 95, 1),
              color: blueColor,
              borderRadius: BorderRadius.circular(8)),
          child: InkWell(
            onTap: () {
               showFilterModal(context,modal);
            },
            child: const SizedBox(
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(
                  width: 6,
                ),
                Image(
                  image: AssetImage('assets/images/filter.png'),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: yellowColor,
                  child: Center(
                      child: Text(
                    '1',
                    style: TextStyle(color: blueColor),
                  )),
                )
              ]),
            ),
          )),
    );
  }
}
