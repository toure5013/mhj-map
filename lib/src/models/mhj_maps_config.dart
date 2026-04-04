class MhjMapsConfig {
  final String valhallaUrl;
  final String nominatimUrl;
  final String photonUrl;

  const MhjMapsConfig({
    this.valhallaUrl = 'https://valhalla1.openstreetmap.de',
    this.nominatimUrl = 'https://nominatim.openstreetmap.org',
    this.photonUrl = 'https://photon.komoot.io',
  });
}
