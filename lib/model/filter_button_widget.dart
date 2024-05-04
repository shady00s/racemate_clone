import 'package:flutter/cupertino.dart';

class FilterButtonWidgetModel {
	final String filterTitle;
	final String filterModalTitle;
	final  Widget  filterComponents;
	final Function  submitOnClick;
	 FilterButtonWidgetModel({required this.filterModalTitle,required this.filterComponents,required this.filterTitle,required this.submitOnClick});
}