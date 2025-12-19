bool isVersionLower(String current, String required) {
  final c = current.split('.').map(int.parse).toList();
  final r = required.split('.').map(int.parse).toList();

  for (int i = 0; i < 3; i++) {
    if (c[i] < r[i]) return true;
    if (c[i] > r[i]) return false;
  }
  return false;
}