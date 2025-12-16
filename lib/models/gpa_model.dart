class GpaModel {
  final String GPA;
  final String Credits;

  GpaModel({
    required this.GPA,
    required this.Credits,
  });
  @override
  String toString() {
    return "GPA: $GPA, Credits: $Credits";
  }
}