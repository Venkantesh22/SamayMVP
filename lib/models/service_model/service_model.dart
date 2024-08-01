class ServiceModel {
  final String id;
  final String salonId;
  final String categoryId;
  final String servicesName;
  final double price;
  final double hours;
  final double minutes;
  final String description;

  ServiceModel({
    required this.id,
    required this.salonId,
    required this.categoryId,
    required this.servicesName,
    required this.price,
    required this.hours,
    required this.minutes,
    required this.description,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      salonId: json['salonId'],
      categoryId: json['categoryId'],
      id: json['id'],
      servicesName: json['servicesName'],
      price: (json['price'] as num).toDouble(), // Convert to double
      hours: (json['hours'] as num).toDouble(), // Convert to double
      minutes: (json['minutes'] as num).toDouble(), // Convert to double
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'salonId': salonId,
      'categoryId': categoryId,
      'id': id,
      'servicesName': servicesName,
      'price': price,
      'hours': hours,
      'minutes': minutes,
      'description': description,
    };
  }
}
