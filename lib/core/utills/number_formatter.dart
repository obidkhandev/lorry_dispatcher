import 'package:intl/intl.dart';

import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

extension NumberFormatter on String {
  String formatAsNumber() {
    final number = num.tryParse(replaceAll(' ', ''));
    if (number != null) {
      final formatter = NumberFormat('#,##0');
      return formatter.format(number).replaceAll(',', ' ');
    }
    return this;
  }
}

num numParser(String? text) {
  var replaceText = text?.replaceAll(' ', '');
  if (text != null) {
    return num.parse(
        (replaceText?.isNotEmpty ?? false) ? '${replaceText ?? 0}' : '0');
  }
  return 0;
}

extension PhoneFormatter on String {
  String get phone {
    var code = substring(0, 2);
    var h = substring(2, 5);
    var s = substring(5, 7);
    var t = substring(7);
    return '+998 ($code) $h - $s - $t';
  }

  String get unmaskedPhone {
    return replaceAll(' ', '')
        .replaceAll('+', '')
        .replaceFirst('998', '')
        .replaceFirst('(', '')
        .replaceFirst(')', '');
  }
}

extension PhoneFormatter2 on String {
  String get phone2 {
    var codePlus = substring(0, 3);
    var code = substring(3, 5);
    var h = substring(5, 8);
    var s = substring(8, 10);
    var t = substring(10);
    return '+($codePlus) $code-$h-$s-$t';
  }
}



final phoneMaskFormatter = MaskTextInputFormatter(mask: '(##) ### ## ##');
// final phoneMaskFormatter = MaskTextInputFormatter(mask: '(##) ### ## ##');

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final String formattedText =
        newValue.text.replaceAll(RegExp(r'\s+'), '').replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match match) => '${match[1]} ',
            );

    return TextEditingValue(
      text: formattedText,
      selection: newValue.selection.copyWith(
        baseOffset: formattedText.length,
        extentOffset: formattedText.length,
      ),
    );
  }
}

class AlphanumericTextInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'[A-Z0-9]');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredText = newValue.text.replaceAllMapped(
      _regExp,
      (match) => match.group(0) ?? '',
    );

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}

String dateFormatter(DateTime time) {
  String formatterDate = DateFormat('dd-MM-yyyy').format(time);
  return formatterDate;
}

String dateFormatterReverse(DateTime time) {
  String formatterDate = DateFormat('yyyy-MM-dd').format(time);
  return formatterDate;
}

String capitalizeFirstLetter(String? text) {
  if (text == null || text.isEmpty) {
    return text ?? '';
  }
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

class CarNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText =
        newValue.text.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
    String formattedText = '';

    for (int i = 0; i < newText.length; i++) {
      if (i == 2 || i == 6) {
        formattedText += ' '; // Adding space after the 2nd and 6th character
      }
      formattedText += newText[i];
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}


class ThousandsSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // Remove any non-numeric characters except for the decimal point
    text = text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Format the number with commas as thousands separator
    if (text.isNotEmpty) {
      text = _formatNumberWithComma(text);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  String _formatNumberWithComma(String number) {
    // Split into integer and decimal parts if exists
    List<String> parts = number.split('.');
    String integerPart = parts[0];

    // Add commas as thousands separator
    String formatted = integerPart.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');

    // Append decimal part back if it exists
    if (parts.length > 1) {
      formatted += '.${parts[1]}';
    }

    return formatted;
  }
}