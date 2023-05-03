class MajorSectionName {
  int sectionNumber;
  String name;
  
  MajorSectionName({required this.sectionNumber, required this.name});

  // Factory method to create a MajorSectionName object from a map
  factory MajorSectionName.fromJson(Map<String, dynamic> json) {
    return MajorSectionName(
      sectionNumber: json['sectionNumber'] as int,
      name: json['name'] as String,
    );
  }

  // Convert a MajorSectionName object to a map
  Map<String, dynamic> toJson() {
    return {
      'sectionNumber': sectionNumber,
      'name': name,
    };
  }
}
