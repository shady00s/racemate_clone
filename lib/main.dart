import 'package:flutter/material.dart';
import 'package:optomatica_race/constants.dart';
import 'package:optomatica_race/view/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Races',
      theme: ThemeData(
        sliderTheme: const SliderThemeData(
          overlayColor: orangeColor,
          inactiveTickMarkColor: orangeColor,
          thumbColor: orangeColor,
        ),
        primaryColor: whiteBackground,
        datePickerTheme: DatePickerThemeData(
          todayBackgroundColor: MaterialStateProperty.resolveWith((states) => whiteBackground),
          dayStyle: const TextStyle(color: blueColor),
        ),
        searchBarTheme: SearchBarThemeData(
            shadowColor: MaterialStateProperty.resolveWith((states) => whiteBackground),
            elevation: MaterialStateProperty.resolveWith((states) => 0),
            backgroundColor: MaterialStateProperty.resolveWith((states) => whiteBackground),
            shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            side: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const BorderSide(color: orangeColor);
              }
              return const BorderSide(color: borderColor);
            })),
        iconTheme: const IconThemeData(color: blueColor),
        inputDecorationTheme: InputDecorationTheme(activeIndicatorBorder: const BorderSide(color: orangeColor), focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: orangeColor), borderRadius: BorderRadius.circular(8)), border: OutlineInputBorder(borderSide: const BorderSide(color: orangeColor), borderRadius: BorderRadius.circular(8))),
        checkboxTheme: CheckboxThemeData(overlayColor: MaterialStateColor.resolveWith((states) {
          return blueColor;
        }), fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return blueColor;
          }
          return whiteBackground;
        }), checkColor: MaterialStateColor.resolveWith((states) {
          return whiteBackground;
        })),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          indicatorColor: Color.fromRGBO(255, 183, 21, 1),
          dividerColor: Colors.white54,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(28, 50, 95, 1),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
