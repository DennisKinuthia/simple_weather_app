import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/components/border_box.dart';
import 'package:my_weather/model/weather_data.dart';
import 'package:my_weather/utils/constants.dart';
import 'package:my_weather/utils/widget_functions.dart';

class WindAndClouds extends StatelessWidget {
  const WindAndClouds({
    Key? key,
    required this.data,
  }) : super(key: key);

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    return BorderBox(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      width: double.infinity,
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Wind',
                  style: GoogleFonts.montserrat(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                addVerticalSpace(5.0),
                Text(
                  '${data.wind.round()} km/h',
                  style: GoogleFonts.montserrat(
                    color: textColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          const VerticalDivider(
            width: 1,
            thickness: 2,
            indent: 14.0,
            endIndent: 14.0,
            color: primaryColor,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Clouds',
                  style: GoogleFonts.montserrat(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                addVerticalSpace(5.0),
                Text(
                  '${data.cloud.round()} %',
                  style: GoogleFonts.montserrat(
                    color: textColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          const VerticalDivider(
            width: 5.0,
            thickness: 2,
            indent: 14.0,
            endIndent: 14.0,
            color: primaryColor,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Humidity',
                  style: GoogleFonts.montserrat(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                addVerticalSpace(5.0),
                Text(
                  '${data.humidity.round()} %',
                  style: GoogleFonts.montserrat(
                    color: textColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
