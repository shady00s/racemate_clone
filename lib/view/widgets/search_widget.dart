import 'package:flutter/material.dart';
import 'package:optomatica_race/constants.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        viewConstraints: const BoxConstraints(
            minHeight: 100,
            maxHeight: 400,),
        builder: (context, controller) => SearchBar(
          hintText: 'Search',
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              trailing: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ],
            ),

        suggestionsBuilder: (context, controller) => List<ListTile>.generate(1, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            }));
  }
}
