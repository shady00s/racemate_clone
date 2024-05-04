import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:optomatica_race/view/widgets/filter/modal_filter_widgets/datetime.dart';
import 'package:optomatica_race/view/widgets/filter/modal_filter_widgets/filter_lcoation.dart';
import 'model/filter_button_widget.dart';

// images paths

const logo = 'assets/images/logo.png';
const appbarBg = 'assets/images/appbar_bg.png';
const notificationIcon = 'assets/images/Notification icon.png';
const profilePicture = 'assets/images/Profile picture.png';

// colors
const whiteBackground = Color.fromRGBO(241, 244, 253, 1);
const blueColor = Color.fromRGBO(28, 50, 95, 1);
const yellowColor = Color.fromRGBO(255, 233, 84, 1);
const borderColor = Color.fromRGBO(205, 211, 228, 1);
const orangeColor = Color.fromRGBO(255, 183, 21, 1);
// filter widgets list

List<FilterButtonWidgetModel> filterWidgetsList = [
  FilterButtonWidgetModel(filterComponents: const FilterLocationWidget(), filterTitle: 'Type', filterModalTitle: 'Run type', submitOnClick: () {}),
  FilterButtonWidgetModel(filterComponents: const FilterLocationWidget(), filterTitle: 'Location', filterModalTitle: 'Race Location', submitOnClick: () {}),
  FilterButtonWidgetModel(filterComponents: const FilterLocationWidget(), filterTitle: 'Distance', filterModalTitle: 'Race Distance', submitOnClick: () {}),
  FilterButtonWidgetModel(filterComponents: const DateTimeModalWidget(), filterTitle: 'Date', filterModalTitle: 'Race Date', submitOnClick: () {}),

];
