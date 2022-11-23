// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/screens/weather_data_screen/weather_info.dart';
import 'package:my_weather/services/weather_api.dart';
import 'package:my_weather/utils/constants.dart';
import 'package:my_weather/utils/get_location.dart';
import 'package:my_weather/utils/widget_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getData() async {
    final api = WeatherApi();
    final currentLocation = await getCurrentLocation();
    final latLong = {
      'lat': currentLocation.latitude.toDouble(),
      'lon': currentLocation.longitude.toDouble(),
    };
    try {
      final String city = await api.fetchCity(latLong);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Weather(city: city),
        ),
      );
    } on WeatherApiException catch (error, st) {
      print('$error: $st');
    } on SocketException catch (_) {
      print('No Internet Connection');
    } catch (error, st) {
      print('$error : $st');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 100.0,
                  ),
                ),
              ),
            ),
            Text('Weather',
                style: GoogleFonts.acme(
                  fontSize: 26.0,
                  color: textColor,
                  letterSpacing: 1.2,
                )),
            Text(
              'v.1.2.0',
              style: GoogleFonts.montserrat(
                fontSize: 13.0,
                color: textColor,
              ),
            ),
            addVerticalSpace(25.0),
          ],
        ),
      ),
    );
  }
}
