class WatchListServiceModel {
  final String id;
  final String salonId;
  final String userId;
  final String salonName;
  final String categoryId;
  final String servicesName;
  final double price;
  final double hours;
  final double minutes;
  final String description;
  final String state;

  WatchListServiceModel({
    required this.id,
    required this.salonId,
    required this.userId,
    required this.salonName,
    required this.categoryId,
    required this.servicesName,
    required this.price,
    required this.hours,
    required this.minutes,
    required this.description,
    required this.state,
  });

  // From JSON
  factory WatchListServiceModel.fromJson(Map<String, dynamic> json) {
    return WatchListServiceModel(
      id: json['id'] as String,
      salonId: json['salonId'] as String,
      userId: json['userId'] as String,
      salonName: json['salonName'] as String,
      categoryId: json['categoryId'] as String,
      servicesName: json['servicesName'] as String,
      price: (json['price'] as num).toDouble(),
      hours: (json['hours'] as num).toDouble(),
      minutes: (json['minutes'] as num).toDouble(),
      description: json['description'] as String,
      state: json['state'] as String,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'salonId': salonId,
      'userId': userId,
      'salonName': salonName,
      'categoryId': categoryId,
      'servicesName': servicesName,
      'price': price,
      'hours': hours,
      'minutes': minutes,
      'description': description,
      'state': state,
    };
  }
}
