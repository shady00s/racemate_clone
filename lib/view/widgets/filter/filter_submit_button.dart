
import 'package:flutter/material.dart';
import 'package:optomatica_race/constants.dart';

class SubmitFilterButton extends StatelessWidget {
  final Function onPressed;
    final String title;
  const SubmitFilterButton({super.key,required this.onPressed,required this.title});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 42,
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: orangeColor,
        onPressed: (){onPressed();},child:  Text(title,style: const TextStyle(fontWeight: FontWeight.bold,color: blueColor),),),
    );
  }
}
