import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_weather/model/weather_data.dart';

class WeatherApiException implements Exception {
  WeatherApiException(this.message);
  final String message;
}

class WeatherApi {
  static const baseUrl = 'https://api.openweathermap.org';
  static const apiToken = 'a3d2d0ce00dc5d3a30b6f8c33d432faf';

  Future<Map<String, dynamic>> fetchLatLong(String city) async {
    final url = Uri.parse('$baseUrl/geo/1.0/direct?q=$city&appid=$apiToken');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw WeatherApiException(
          'Error fetching latitude and longitude for $city');
    }
    final data = json.decode(response.body);
    if (data.isEmpty) {
      throw WeatherApiException(
          'Could not get any latitude and longitude information for $city');
    }
    return {
      'lat': data[0]['lat'],
      'lon': data[0]['lon'],
      'country': data[0]['country'],
      'city': data[0]['name'],
    };
  }

  Future<String> fetchCity(Map<String, dynamic> latLong) async {
    final lat = latLong['lat'];
    final lon = latLong['lon'];
    final url =
        Uri.parse('$baseUrl/geo/1.0/reverse?lat=$lat&lon=$lon&appid=$apiToken');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw WeatherApiException('Error fetching city name');
    }
    final data = json.decode(response.body);
    if (data.isEmpty) {
      throw WeatherApiException('Could not get the city');
    }

    return data[0]['name'] as String;
  }

  Future<WeatherData> fetchWeatherData(Map<String, dynamic> latLong) async {
    final lat = latLong['lat'];
    final lon = latLong['lon'];
    if (lat == null || lon == null) {
      throw WeatherApiException('Latitude and Longitude data is not available');
    }
    final url = Uri.parse(
        '$baseUrl/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiToken&units=metric');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw WeatherApiException(
          'Error fetching weather information for $lat, $lon');
    }
    final data = json.decode(response.body);
    if (data.isEmpty) {
      throw WeatherApiException(
          'Could not get any weather information for $lat, $lon');
    }
    final consolidate = {
      'condition': data['weather'][0]['main'],
      'temp': data['main']['temp'],
      'country': data['sys']['country'],
      'city': data['name'],
      'wind': data['wind']['speed'],
      'cloud': data['clouds']['all'],
      'humidity': data['main']['humidity'],
      'desc': data['weather'][0]['description']
    };
    return WeatherData.fromJson(consolidate);
  }

  Future<WeatherData> getWeatherData(String city) async {
    final latLong = await fetchLatLong(city);
    return fetchWeatherData(latLong);
  }
}
