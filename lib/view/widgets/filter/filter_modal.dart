import 'package:flutter/material.dart';
import '../../../view_model/filter_view_model.dart';

Future<void> showFilterModal(BuildContext context, FilterButtonWidgetViewModel modal, Widget widget, Widget bottomWidget, Function? onReset) async {
  return await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
                width: 80,
                height: 10,
                child: Card(
                  color: Color.fromRGBO(205, 211, 228, 1),
                )),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                    flex: 3,
                    child: Text(
                      modal.filterModalTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    )),
                Expanded(
                    flex: 1,
                    child:onReset !=null? TextButton(
                        onPressed: () {
                          onReset();
                        },
                        child: const Text(
                          'RESET',
                          style: TextStyle(color: Color.fromRGBO(189, 80, 0, 1)),
                        )
                    ):const SizedBox()
                )
              ],
            ),
            widget,
            bottomWidget
          ],
        ),
      ));
}
