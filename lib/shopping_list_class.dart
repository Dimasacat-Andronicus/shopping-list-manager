class ShoppingItem {
  String name;
  String quantity;
  String brand;

  ShoppingItem({required this.name, this.quantity = "", this.brand = ""});
}

class ListData {
  static List<ShoppingItem> itemList = [];
  static List<ShoppingItem> filteredList = [];
}
