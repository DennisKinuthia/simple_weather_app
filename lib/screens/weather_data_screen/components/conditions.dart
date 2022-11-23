import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/model/weather_data.dart';
import 'package:my_weather/utils/constants.dart';
import 'package:my_weather/utils/weather_pics.dart';
import 'package:my_weather/utils/widget_functions.dart';

class Conditions extends StatelessWidget {
  const Conditions({
    Key? key,
    required this.padding,
    required this.data,
  }) : super(key: key);

  final double padding;
  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage(pics[data.condition]!),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${data.temp.round()}',
                  style: GoogleFonts.roboto(
                    color: secondaryColor,
                    fontSize: 90.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '°C',
                  style: GoogleFonts.montserrat(
                    color: secondaryColor,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Text(
              '${data.desc[0].toUpperCase()}${data.desc.substring(1)}',
              style: GoogleFonts.montserrat(
                color: textColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            addVerticalSpace(padding),
          ],
        ),
      ],
    );
  }
}
