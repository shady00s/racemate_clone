import 'package:flutter/material.dart';
import 'package:optomatica_race/view/widgets/race_card.dart';
import '../widgets/filter/filter.dart';
import '../widgets/search_widget.dart';

class RacesScreen extends StatelessWidget {
  const RacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SearchWidget(),
          const FilterWidget(),
          Expanded(child: ListView.builder(itemCount: 9, itemBuilder: (builder, index) => const RaceCardWidget())),
        ],
      ),
    );
  }
}
