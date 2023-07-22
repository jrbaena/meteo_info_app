extension StringExtension on String {
  String replaceSpecialCharacters() {
    return replaceAll("á", "a")
        .replaceAll("é", "e")
        .replaceAll("í", "i")
        .replaceAll("ó", "o")
        .replaceAll("ú", "u")
        .replaceAll("Á", "a")
        .replaceAll("É", "e")
        .replaceAll("Í", "i")
        .replaceAll("Ó", "o")
        .replaceAll("Ú", "u");
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}