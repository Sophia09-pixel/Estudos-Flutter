class Time {
  final int id;
  final String name;
  final String logo;
  Time({required this.id, required this.name, required this.logo});
  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(id: json['id'], name: json['name'], logo: json['logo']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'logo': logo};
}
