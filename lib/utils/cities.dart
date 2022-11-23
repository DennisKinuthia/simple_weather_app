class City {
  const City(
    this.flag,
    this.name,
    this.country,
  );

  final String flag;
  final String name;
  final String country;
}

List<City> cities = [
  const City('assets/images/kenya.png', 'Nairobi', 'Kenya'),
  const City('assets/images/syria.png', 'Damascus', 'Syria'),
  const City('assets/images/uae.png', 'Dubai', 'UAE'),
  const City('assets/images/canada.jpg', 'Toronto', 'Canada'),
  const City('assets/images/australia.png', 'Sydney', 'Australia'),
  const City('assets/images/uk.png', 'London', 'Britain'),
  const City('assets/images/france.png', 'Paris', 'France'),
  const City('assets/images/egypt.png', 'Cairo', 'Egypt'),
  const City('assets/images/uganda.png', 'Kampala', 'Uganda'),
  const City('assets/images/tanzania.jpeg', 'Dodoma', 'Tanzania'),
  const City('assets/images/qatar.png', 'Doha', 'Qatar'),
  const City('assets/images/germany.png', 'Berlin', 'Germany'),
];
