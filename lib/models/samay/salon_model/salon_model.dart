class Salon {
  String id;
  String appointmentNo;

  Salon({required this.id, required this.appointmentNo});

  factory Salon.fromJson(Map<String, dynamic> json) {
    return Salon(
      id: json['id'],
      appointmentNo: json['appointmentNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointmentNo': appointmentNo,
    };
  }

  Salon copyWith({String? id, String? appointmentNo}) {
    return Salon(
      id: id ?? this.id,
      appointmentNo: appointmentNo ?? this.appointmentNo,
    );
  }
}
