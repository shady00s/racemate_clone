import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../model/races_model.dart';

class RaceCardWidget extends StatelessWidget {
  final RacesDataModel raceData;
  const RaceCardWidget({super.key, required this.raceData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184,
      width: MediaQuery.sizeOf(context).width,
      child: Card(
        color: whiteBackground,
        elevation: 3,
        child: Row(
          children: [
            const Expanded(flex: 2, child: Placeholder()),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.stars_rounded),
                    Text(
                      raceData.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, color: Color.fromRGBO(0, 10, 53, 1), fontWeight: FontWeight.bold),
                    ),
                    raceData.organizer != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Organized by',
                                style: TextStyle(color: Color.fromRGBO(142, 155, 195, 1)),
                              ),
                              Text(
                                raceData.organizer ?? '',
                                style: const TextStyle(color: Color.fromRGBO(189, 80, 0, 1)),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWithIcon(
                                iconData: Icons.route,
                                data: '${raceData.distances.join('K, ')}K',
                              ),
                              TextWithIcon(
                                iconData: Icons.date_range_rounded,
                                data:DateFormat('d MMMM, y').format(DateTime.parse(raceData.date)),
                              ),
                              TextWithIcon(
                                iconData: Icons.location_on,
                                data: '${raceData.city}, ${raceData.country}',
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                            flex: 1,
                            child: Image(
                              image: AssetImage('assets/images/share.png'),
                            )),
                        const SizedBox(
                          width: 15,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final IconData iconData;
  final String data;
  const TextWithIcon({super.key, required this.iconData, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(iconData, size: 16),
        const SizedBox(
          width: 4,
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.35,
          child: Text(
            data,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        )
      ],
    );
  }
}
