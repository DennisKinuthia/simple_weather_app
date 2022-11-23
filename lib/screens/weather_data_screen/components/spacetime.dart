import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/utils/constants.dart';

class SpaceTime extends StatelessWidget {
  const SpaceTime({
    Key? key,
    required this.today,
    required this.data,
  }) : super(key: key);

  final String today;
  final Map data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          today,
          style: GoogleFonts.montserrat(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          '${data["city"]}, ${data["country"]}',
          style: GoogleFonts.montserrat(
            color: textColor,
            fontSize: 15.0,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
