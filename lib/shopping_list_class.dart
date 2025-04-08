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
