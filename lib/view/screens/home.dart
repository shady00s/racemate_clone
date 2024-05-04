import 'package:flutter/material.dart';
import 'package:optomatica_race/view/screens/races.dart';
import '../../constants.dart';
import 'challenges.dart';
import 'community.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Image(
                image: AssetImage(logo),
              ),
              flexibleSpace:const Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    appbarBg,
                  )),
              actions: const [
                Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      notificationIcon,
                    )),
                SizedBox(width: 20,),
                Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      profilePicture,
                    )),
                SizedBox(width: 20,),
              ],
              bottom: const TabBar(
                indicatorWeight: 5,
                tabs: [
                  Tab(child: Text('RUN'),),
                  Tab(child: Text('COMMUNITY'),),
                  Tab(child: Text('RACES'),),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                RacesScreen(),
                ChallengesScreen(),
                CommunityScreen(),
              ],
            ),
          )),
    );
  }
}
