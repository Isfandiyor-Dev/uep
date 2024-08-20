class Validator {
  // Telefon raqam uchun validator
  static String? validatePhoneNumber(String? value) {
    final phoneRegExp = RegExp(r'^\d{9,15}$');
    if (value == null || value.isEmpty) {
      return 'Telefon raqamini kiriting';
    } else if (!phoneRegExp.hasMatch(value)) {
      return 'Yaroqli telefon raqamini kiriting (masalan, +998901234567)';
    }
    return null; // Hammasi yaxshi bo'lsa, null qaytadi
  }

  // Ism uchun validator
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ismingizni kiriting';
    } else if (value.length < 2) {
      return 'Ismingiz kamida 2 ta belgidan iborat bo\'lishi kerak';
    }
    return null; // Hammasi yaxshi bo'lsa, null qaytadi
  }

  // Parol uchun validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Parolni kiriting';
    } else if (value.length < 8) {
      return 'Parol kamida 8 ta belgidan iborat bo\'lishi kerak';
    }
    return null; // Hammasi yaxshi bo'lsa, null qaytadi
  }

  // Parolni tasdiqlash (confirm password) uchun validator
  static String? validateConfirmPassword(
      String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Parolni tasdiqlang';
    } else if (value != originalPassword) {
      return 'Parollar mos kelmayapti';
    }
    return null; // Hammasi yaxshi bo'lsa, null qaytadi
  }
}
