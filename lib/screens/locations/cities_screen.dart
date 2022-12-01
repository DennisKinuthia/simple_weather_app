// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/model/favorites.dart';
import 'package:my_weather/screens/favorites/favorites_screen.dart';
import 'package:my_weather/screens/weather_data_screen/weather_info.dart';
import 'package:my_weather/utils/cities.dart';
import 'package:my_weather/utils/constants.dart';
import 'package:provider/provider.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _Location();
}

class _Location extends State<Location> {
  Icon iconType = const Icon(
    Icons.favorite_border_outlined,
    color: Colors.white,
  );

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
            onTap: () {},
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
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 7.0,
                      blurRadius: 10.0,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Consumer<Favourites>(
                  builder: (context, favs, child) {
                    return SingleCity(
                      index: index,
                      favs: favs,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SingleCity extends StatefulWidget {
  const SingleCity({
    Key? key,
    required this.index,
    required this.favs,
  }) : super(key: key);

  final int index;
  final Favourites favs;

  @override
  State<SingleCity> createState() => _SingleCityState();
}

class _SingleCityState extends State<SingleCity> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    if (widget.favs.cities.contains(cities[widget.index].name)) {
      _isSelected = true;
    } else {
      _isSelected = false;
    }
    return ListTile(
      leading: CircleAvatar(
        radius: 50.0,
        backgroundImage: AssetImage(cities[widget.index].flag),
      ),
      title: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          cities[widget.index].name,
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
          cities[widget.index].country,
          style: GoogleFonts.montserrat(
            color: textColor,
            fontSize: 15.0,
          ),
        ),
      ),
      trailing: Consumer<Favourites>(
        builder: ((context, value, child) {
          return IconButton(
            onPressed: () {
              setState(() {
                _isSelected = true;
              });
              value.addCityToFavs(cities[widget.index].name);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Favourtes(),
                ),
              );
            },
            icon: _isSelected
                ? const Icon(
                    Icons.favorite,
                    color: Colors.pinkAccent,
                  )
                : const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                  ),
          );
        }),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Weather(city: cities[widget.index].name),
          ),
        );
      },
    );
  }
}
