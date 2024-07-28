class CategoryModel {
  final String id;
  final String categoryName;
  final String salonId;
  final bool haveData;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.salonId,
    required this.haveData,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'id': id,
      'salonId': salonId,
      'haveData': haveData,
    };
  }

  // Factory constructor to create an instance from a JSON map
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '', // Providing default values if the key is missing
      categoryName: json['categoryName'] ?? '',
      salonId: json['salonId'] ?? '',
      haveData: json['haveData'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryName": categoryName,
        "salonId": salonId,
        "haveData": haveData,
      };
}
