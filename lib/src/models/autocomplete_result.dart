class AutocompleteResult {
  final double lat;
  final double lng;
  final String displayName;
  final String name;
  final String? city;
  final String? state;
  final String? country;
  final String? street;
  final String? postcode;

  const AutocompleteResult({
    required this.lat,
    required this.lng,
    required this.displayName,
    required this.name,
    this.city,
    this.state,
    this.country,
    this.street,
    this.postcode,
  });

  factory AutocompleteResult.fromJson(Map<String, dynamic> json) {
    return AutocompleteResult(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      displayName: json['displayName'] ?? '',
      name: json['name'] ?? '',
      city: json['city'],
      state: json['state'],
      country: json['country'],
      street: json['street'],
      postcode: json['postcode'],
    );
  }
}
