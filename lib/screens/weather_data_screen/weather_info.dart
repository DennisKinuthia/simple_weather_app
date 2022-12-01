// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/components/border_box.dart';
import 'package:my_weather/screens/favorites/favorites_screen.dart';
import 'package:my_weather/screens/locations/cities_screen.dart';
import 'package:my_weather/screens/weather_data_screen/components/conditions.dart';
import 'package:my_weather/screens/weather_data_screen/components/wind_and_clouds.dart';
import 'package:my_weather/services/weather_api.dart';
import 'package:my_weather/utils/constants.dart';
import 'package:my_weather/utils/helper_functions.dart';
import 'package:my_weather/utils/widget_functions.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'components/spacetime.dart';

class Weather extends StatefulWidget {
  const Weather({required this.city, super.key});
  final String city;

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  int _selectedIndex = 0;

  void _onTap(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final String today = formatDateTime(DateTime.now());
    // final data = ModalRoute.of(context)!.settings.arguments as Map;
    const double padding = 25.0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 20.0,
        splashColor: primaryColor,
        backgroundColor: secondaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Favourtes(),
            ),
          );
        },
        tooltip: 'Favorite',
        child: Icon(
          Icons.favorite,
          color: Colors.pinkAccent,
        ),
      ),
      bottomNavigationBar: StylishBottomBar(
        padding: const EdgeInsets.only(top: 10.0),
        inkEffect: true,
        inkColor: accent,
        items: [
          AnimatedBarItems(
            icon: const Icon(
              Icons.home,
              color: secondaryColor,
            ),
            selectedColor: primaryColor,
            backgroundColor: Colors.blueGrey.withOpacity(0.6),
            title: Text(
              'Home',
              style: GoogleFonts.montserrat(color: secondaryColor),
            ),
          ),
          AnimatedBarItems(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Location(),
                  ),
                );
              },
              child: Icon(
                Icons.menu,
                color: secondaryColor,
              ),
            ),
            selectedColor: primaryColor,
            backgroundColor: Colors.blueGrey.withOpacity(0.6),
            title: Text(
              'Cities',
              style: GoogleFonts.montserrat(color: secondaryColor),
            ),
          ),
          AnimatedBarItems(
            icon: const Icon(
              Icons.search_rounded,
              color: secondaryColor,
            ),
            selectedColor: primaryColor,
            backgroundColor: Colors.blueGrey.withOpacity(0.6),
            title: Text(
              'Search',
              style: GoogleFonts.montserrat(color: secondaryColor),
            ),
          ),
          AnimatedBarItems(
            icon: const Icon(
              Icons.person,
              color: secondaryColor,
            ),
            selectedColor: primaryColor,
            backgroundColor: Colors.blueGrey.withOpacity(0.6),
            title: Text(
              'Account',
              style: GoogleFonts.montserrat(color: secondaryColor),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 31, 43, 71),
        elevation: 10.0,
        iconSize: 32.0,
        barAnimation: BarAnimation.fade,
        iconStyle: IconStyle.animated,
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        opacity: 0.3,
        unselectedIconColor: secondaryColor,
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: padding, vertical: padding),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BorderBox(
                    width: 40.0,
                    height: 40.0,
                    child: IconButton(
                      onPressed: () {},
                      splashRadius: 22.0,
                      icon: Icon(
                        size: 22.0,
                        Icons.notifications,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: WeatherApi().fetchLatLong(widget.city),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = {
                            'city': snapshot.data!['city'],
                            'country': snapshot.data!['country'],
                          };
                          return SpaceTime(today: today, data: data);
                        } else {
                          return Expanded(
                            child: Center(
                              child: Image.asset('assets/images/ripple.gif'),
                            ),
                          );
                        }
                      }),
                ],
              ),
              addVerticalSpace(padding),
              FutureBuilder(
                future: WeatherApi().getWeatherData(widget.city),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return Conditions(
                      padding: padding,
                      data: data,
                    );
                  } else {
                    return Expanded(
                      child: Center(
                        child: Image.asset('assets/images/ripple.gif'),
                      ),
                    );
                  }
                },
              ),
              addVerticalSpace(padding),
              FutureBuilder(
                future: WeatherApi().getWeatherData(widget.city),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return WindAndClouds(data: data);
                  } else {
                    return Expanded(
                      child: Center(
                        child: Image.asset('assets/images/ripple.gif'),
                      ),
                    );
                  }
                },
              ),
              addVerticalSpace(padding * 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: accent,
                      border: Border.all(
                        width: 1.0,
                        color: Colors.blueGrey.withOpacity(0.6),
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    width: size.width * 0.25,
                    height: 30.0,
                    child: Center(
                      child: Text(
                        'Today',
                        style: GoogleFonts.montserrat(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.blueGrey.withOpacity(0.6),
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    width: size.width * 0.25,
                    height: 30.0,
                    child: Center(
                      child: Text(
                        'Tomorrow',
                        style: GoogleFonts.montserrat(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.blueGrey.withOpacity(0.6),
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    width: size.width * 0.25,
                    height: 30.0,
                    child: Center(
                      child: Text(
                        '7 Days',
                        style: GoogleFonts.montserrat(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(padding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: size.width * 0.24,
                    height: size.height * 0.22,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45.0),
                        bottom: Radius.circular(47.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40.0,
                            backgroundColor: Color.fromARGB(255, 31, 41, 46)
                                .withOpacity(0.3),
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 50.0,
                            ),
                          ),
                          Text(
                            '8°',
                            style: GoogleFonts.roboto(
                              color: secondaryColor,
                              fontSize: 34.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ClipOval(
                            child: Container(
                              width: double.infinity,
                              height: 34.0,
                              color: Colors.amberAccent,
                              child: Center(child: Text('12.00')),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.24,
                    height: size.height * 0.22,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45.0),
                        bottom: Radius.circular(47.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40.0,
                            backgroundColor: Color.fromARGB(255, 31, 41, 46)
                                .withOpacity(0.3),
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 50.0,
                            ),
                          ),
                          Text(
                            '8°',
                            style: GoogleFonts.roboto(
                              color: secondaryColor,
                              fontSize: 34.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ClipOval(
                            child: Container(
                              width: double.infinity,
                              height: 34.0,
                              color: Colors.amberAccent,
                              child: Center(child: Text('13.00')),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.24,
                    height: size.height * 0.22,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45.0),
                        bottom: Radius.circular(47.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40.0,
                            backgroundColor: Color.fromARGB(255, 31, 41, 46)
                                .withOpacity(0.3),
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 50.0,
                            ),
                          ),
                          Text(
                            '8°',
                            style: GoogleFonts.roboto(
                              color: secondaryColor,
                              fontSize: 34.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ClipOval(
                            child: Container(
                              width: double.infinity,
                              height: 34.0,
                              color: Colors.amberAccent,
                              child: Center(child: Text('14.00')),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(40.0),
            ],
          ),
        ),
      ),
    );
  }
}
