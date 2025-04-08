import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void promptDialog(context, content, listName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "Success",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        content: Text(
          "The item \"$listName\" $content successfully!",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2.0),
              child: Text(
                "Close",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

//Decimal point Formatter for price
class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalRange;

  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;

    if (text == '') {
      return newValue;
    }

    if (text == '.') {
      return TextEditingValue(
        text: '0.',
        selection: newValue.selection.copyWith(baseOffset: 2, extentOffset: 2),
      );
    }

    final parts = text.split('.');

    if (parts.length > 2) {
      return oldValue;
    }

    if (parts.length == 2 && parts[1].length > decimalRange) {
      return oldValue;
    }

    return newValue;
  }
}