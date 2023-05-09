class MajorSectionName {
  int sectionNumber;
  String name;
  
  MajorSectionName({required this.sectionNumber, required this.name});

  // Factory method to create a MajorSectionName object from a map
  factory MajorSectionName.fromMap(Map<String, dynamic> json) {
    return MajorSectionName(
      sectionNumber: json['sectionNumber'] as int,
      name: json['name'] as String,
    );
  }

  // Convert a MajorSectionName object to a map
  Map<String, dynamic> toMap() {
    return {
      'sectionNumber': sectionNumber,
      'name': name,
    };
  }
}
