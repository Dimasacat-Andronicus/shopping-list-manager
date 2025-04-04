import 'package:flutter/services.dart';

//Class to hold the shopping item details
class ShoppingItem {
  String name;
  String quantity;
  String brand;
  double price;
  String category;

  ShoppingItem({
    required this.name,
    this.quantity = "",
    this.brand = "",
    this.price = 0.0,
    this.category = "",
  });
}

// ListData class to hold the list of items
class ListData {
  static List<ShoppingItem> itemList = [];
  static List<ShoppingItem> filteredList = [];
}

// List of categories for the shopping items
const List<String> categories = [
  "Food and Beverages",
  "Clothing and Accessories",
  "Health and Hygiene",
  "Home and Living",
  "Electronics and Technology",
  "Entertainment and Hobbies",
  "Others",
];

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
