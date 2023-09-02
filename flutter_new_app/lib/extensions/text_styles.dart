import '../modules/add/add_imports.dart';

extension TextStyles on TextStyle {
  TextStyle get boldBlackText16 => const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
  TextStyle get boldText => const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle get mediumTextItem => const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400);

  TextStyle get boldText28 => const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500);
  TextStyle get lightSmall => const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400);

  TextStyle get lightWhite => const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400);
  TextStyle get bigWhite => const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500);
  TextStyle get lightGrey => const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400);

  TextStyle get redText => const TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle get greenText => const TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.w500);
}