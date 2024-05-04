import 'package:flutter/material.dart';
import '../../constants.dart';


class RaceCardWidget extends StatelessWidget {
  const RaceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184,
      width: MediaQuery.sizeOf(context).width,
      child: const Card(
        color: whiteBackground,
        elevation: 3,
        child: Row(
          children: [
            Expanded(flex: 2, child: Placeholder()),
            SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.stars_rounded),
                  Text('asdasdasd',style: TextStyle(fontSize: 16,color: Color.fromRGBO(0, 10, 53, 1),fontWeight: FontWeight.bold),),
                  Text('asdasdasd',style: TextStyle(color:Color.fromRGBO( 142, 155, 195, 1)),),
                  Text('asdasdasd',style: TextStyle(color: Color.fromRGBO(189, 80, 0, 1)),),
                  Row(
                    children: [
                      Column(
                        children: [
                          TextWithIcon(),
                          TextWithIcon(),
                          TextWithIcon(),
                        ],
                      ),
                      Spacer(),
                      Image(image: AssetImage('assets/images/share.png'),),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.route,size: 16 ,color: Color.fromRGBO(75, 91, 141, 1),)
        ,SizedBox(width: 4,)
        , Text('adasd')
      ],
    );
  }
}
