// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/screens/weather_data_screen/weather_info.dart';
import 'package:my_weather/utils/cities.dart';
import 'package:my_weather/utils/constants.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _Location();
}

class _Location extends State<Location> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20.0,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: textColor,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Weather(city: cities[index].name),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                height: size.height / 10,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.blueGrey.withOpacity(0.6),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage(cities[index].flag),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      cities[index].name,
                      style: GoogleFonts.montserrat(
                        color: textColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                    child: Text(
                      cities[index].country,
                      style: GoogleFonts.montserrat(
                        color: textColor,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.favorite_outline,
                    color: textColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
