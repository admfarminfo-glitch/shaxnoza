final RegExp phoneRegex = RegExp(r'^\+998\d{9}$');

String? validatePhone(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Telefon raqami kiriting.';
  }
  if (!phoneRegex.hasMatch(value.trim())) {
    return 'Telefon formati +998XXXXXXXXX bo\'lishi kerak.';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Parol kiriting.';
  }
  if (value.trim().length < 4) {
    return 'Parol kamida 4 ta belgidan iborat bo\'lsin.';
  }
  return null;
}
