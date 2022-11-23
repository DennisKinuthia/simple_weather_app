class WeatherData {
  const WeatherData(
      {required this.condition,
      required this.temp,
      required this.city,
      required this.country,
      required this.wind,
      required this.cloud,
      required this.desc,
      required this.humidity});
  final String condition;
  final double temp;
  final String city;
  final String country;
  final double wind;
  final int cloud;
  final String desc;
  final int humidity;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        condition: json['condition'],
        temp: json['temp'],
        city: json['city'],
        country: json['country'],
        wind: json['wind'],
        cloud: json['cloud'],
        desc: json['desc'],
        humidity: json['humidity'],
      );
}
