class OngkirService {
  final String service;
  final String description;
  final int value;
  final String etd;

  OngkirService({
    required this.service,
    required this.description,
    required this.value,
    required this.etd,
  });

  factory OngkirService.fromJson(Map<String, dynamic> json) {
    final cost = json['cost'][0];
    return OngkirService(
      service: json['service'],
      description: json['description'],
      value: cost['value'],
      etd: cost['etd'],
    );
  }
}
