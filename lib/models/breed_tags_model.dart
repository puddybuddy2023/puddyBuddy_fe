class BreedTag {
  late int breedTagId;
  late String BreedTagName;

  BreedTag({
    required this.breedTagId,
    required this.BreedTagName,
  });

  factory BreedTag.fromJson(Map<String, dynamic> json) {
    return BreedTag(
        breedTagId: json['breedTagId'],
        BreedTagName: json['BreedTagName']);
  }
}