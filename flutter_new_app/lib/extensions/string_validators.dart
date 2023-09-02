extension StringValidators on String {
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));

  bool get containsLowercase => contains(RegExp(r'[a-z]'));

  bool get containsSpecialSymbol => contains(RegExp(r'(?=.*?[!@#&*~()])'));

  bool get containsNumeric => contains(RegExp(r'\d'));
}
