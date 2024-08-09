class ServiceModel {
  final String id;
  final String salonId;
  final String categoryId;
  final String categoryName;
  final String servicesName;
  final double price;
  final double hours;
  final double minutes;
  final String description;

  ServiceModel({
    required this.id,
    required this.salonId,
    required this.categoryId,
    required this.categoryName,
    required this.servicesName,
    required this.price,
    required this.hours,
    required this.minutes,
    required this.description,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      // salonId: 'klsfjlk',
      salonId: json['salonId'],
      categoryId: json['categoryId'],
      // categoryName: 'categoryName',
      categoryName: json['categoryName'],
      servicesName: json['servicesName'],
      price: (json['price'] as num?)?.toDouble() ??
          0.0, // Convert to double, default to 0.0 if null
      hours: (json['hours'] as num?)?.toDouble() ??
          0.0, // Convert to double, default to 0.0 if null
      minutes: (json['minutes'] as num?)?.toDouble() ??
          0.0, // Convert to double, default to 0.0 if null
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'salonId': salonId,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'servicesName': servicesName,
      'price': price,
      'hours': hours,
      'minutes': minutes,
      'description': description,
    };
  }
}
