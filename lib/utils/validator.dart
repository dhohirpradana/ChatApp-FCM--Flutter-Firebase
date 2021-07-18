class Validation {
  validatePassword(String value) {
    if (value.length < 4) {
      return 'Password Minimal 4 Karakter';
    }
    return null;
  }

  validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Email Tidak Valid';
    }
    return null;
  }

  validateName(String value) {
    if (value.isEmpty) {
      return 'Nama Tidak Boleh Kosong';
    }
    return null;
  }
}
