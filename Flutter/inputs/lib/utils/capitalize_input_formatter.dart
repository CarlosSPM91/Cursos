import 'package:flutter/services.dart';

class CapitalizeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(_, TextEditingValue newValue) {
    final text = newValue.text.trim();
    if (text.isEmpty) {
      return newValue;
    }

    final newText = "${text[0].toUpperCase()}${text.substring(1, text.length)}";

    return newValue.copyWith(
      text: newText,
      composing: TextRange(start: 0, end: newText.length),
      selection: TextSelection(
          baseOffset: newText.length, extentOffset: newText.length),
    );
  }
}
