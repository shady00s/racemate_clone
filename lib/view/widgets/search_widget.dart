import 'package:flutter/material.dart';
import 'package:optomatica_race/constants.dart';
import 'package:optomatica_race/view_model/races_view_model.dart';

class SearchWidget extends StatefulWidget {
   final RacesViewModel racesViewModel;

    const SearchWidget({super.key,required this.racesViewModel});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  SearchController controller = SearchController();
  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged:(text){
            widget.racesViewModel.racesSearch(text);
        },
        decoration: const InputDecoration(
            hintText: 'Search',suffixIcon: Icon(Icons.search)),);
  }
}
// SearchAnchor(
// viewConstraints: const BoxConstraints(
// minHeight: 100,
// maxHeight: 400,),
// builder: (context, controller) => SearchBar(
// hintText: 'Search',
// onTap: () {
// controller.openView();
// },
// onChanged: (text) {
// controller.openView();
// widget.racesViewModel.racesSearch(text);
// },
// trailing: <Widget>[
// IconButton(
// onPressed: () {},
// icon: const Icon(Icons.search),
// ),
// ],
// ),
//
// suggestionsBuilder: (context, controller) => List<ListTile>.generate(1, (int index) {
// final String item = 'item $index';
// return ListTile(
// title: Text(item),
// onTap: () {
// setState(() {
// controller.closeView(item);
// });
// },
// );
// }));