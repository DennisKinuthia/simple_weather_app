import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/model/favorites.dart';
import 'package:my_weather/screens/weather_data_screen/weather_info.dart';
import 'package:provider/provider.dart';

class Favourtes extends StatefulWidget {
  const Favourtes({super.key});

  @override
  State<Favourtes> createState() => _FavourtesState();
}

class _FavourtesState extends State<Favourtes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Favourites',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                Provider.of<Favourites>(context, listen: false).clearFavs(),
            icon: const Icon(
              Icons.delete_forever,
            ),
          ),
        ],
      ),
      body: Consumer<Favourites>(
        builder: (context, favs, child) {
          return favs.cities.isEmpty
              ? Center(
                  child: Text(
                    'No Cities added yet',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListOfFavs(
                  favs: favs,
                );
        },
      ),
    );
  }
}

class ListOfFavs extends StatelessWidget {
  const ListOfFavs({
    Key? key,
    required this.favs,
  }) : super(key: key);

  final Favourites favs;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: favs.cities.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Weather(city: favs.cities[index]),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: size.height / 10,
            margin: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
            padding: const EdgeInsets.all(12.0),
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
            child: ListTile(
              title: Text(
                favs.cities[index],
                style: GoogleFonts.montserrat(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              trailing: GestureDetector(
                onTap: () => favs.removeCityFromFavs(favs.cities[index]),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
