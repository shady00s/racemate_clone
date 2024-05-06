import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Padding(padding:  EdgeInsets.all(18.0), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Center(child: Text('No community found'))
    ]));
  }
}
