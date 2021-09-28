String capitalizeName(String s) {
  String name = '';
  if (s.trim().isNotEmpty) {
    name = s[0].toUpperCase() + s.substring(1);
    for (int i = 0; i < s.trim().length; i++) {
      if (s[i].contains(' ')) {
        name = name.substring(0, i) +
            ' ' +
            s[i + 1].toUpperCase() +
            s.substring(i + 2);
      }
    }
  }
  return name;
}
