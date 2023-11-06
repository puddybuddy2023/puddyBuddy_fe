class Prefer {
  late int preferId;
  late int userId;
  late String breedTagID;
  late String personalColorId;
  late String name;
  late String chest;
  late String back;

  Prefer({
    required this.preferId,
    required this.userId,
    required this.breedTagID,
    required this.personalColorId,
    required this.name,
    required this.chest,
    required this.back,
  });

  factory Prefer.fromJson(Map<String, dynamic> json) {
    return Prefer(
        preferId: json['preferId'],
        userId: json['userId'],
        breedTagID: json['breedTagID'],
        personalColorId: json['personalColorId'],
        name: json['name'],
        chest: json['chest'],
        back: json['back']);
  }
}