import 'package:flutter/material.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(padding:  EdgeInsets.all(18.0), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Center(child: Text('No challenges found'))
    ]));
  }
}
