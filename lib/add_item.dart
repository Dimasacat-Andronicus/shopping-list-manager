import 'package:crud_flutter_shopping/reusable_widget.dart';
import 'package:flutter/services.dart';

import 'shopping_list_class.dart';
import 'package:flutter/material.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF546E7A),
          secondary: Color(0xFFF0F4F8),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AddItemDisplay(),
    );
  }
}

class AddItemDisplay extends StatefulWidget {
  const AddItemDisplay({super.key});

  @override
  State<AddItemDisplay> createState() => _AddItemDisplayState();
}

class _AddItemDisplayState extends State<AddItemDisplay> {
  final _listName = TextEditingController();
  final _quantity = TextEditingController();
  final _brand = TextEditingController();
  final _price = TextEditingController();
  String _selectedCategory = "Others";

  void _addItem() {
    var content = "saved";
    if (_listName.text.isNotEmpty) {
      setState(() {
        ListData.itemList.add(
          ShoppingItem(
            name: _listName.text,
            quantity: _quantity.text,
            brand: _brand.text,
            price: double.tryParse(_price.text) ?? 0.0,
            category: _selectedCategory,
          ),
        );
        promptDialog(context, content, _listName.text);
        _listName.clear();
        _quantity.clear();
        _brand.clear();
        _price.clear();
        _selectedCategory = "Others";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _listName,
              decoration: InputDecoration(
                labelText: "Item Name *",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                prefixIcon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.grey.shade600,
                ),
              ),
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _quantity,
              decoration: InputDecoration(
                labelText: "Quantity (optional)",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                prefixIcon: Icon(
                  Icons.numbers_outlined,
                  color: Colors.grey.shade600,
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  int? numValue = int.tryParse(value);
                  if (numValue == null || numValue <= 0 || numValue > 999999) {
                    _quantity.text = value.substring(0, value.length - 1);
                  }
                }
              },
            ),
            SizedBox(height: 12),
            TextField(
              controller: _brand,
              decoration: InputDecoration(
                labelText: "Brand (optional)",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                prefixIcon: Icon(
                  Icons.label_outline,
                  color: Colors.grey.shade600,
                ),
              ),
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _price,
              decoration: InputDecoration(
                labelText: "Price (optional)",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "₱",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                  ),
                ),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                DecimalTextInputFormatter(decimalRange: 2),
              ],
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                prefixIcon: Icon(
                  Icons.category_outlined,
                  color: Colors.grey.shade600,
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: "Food and Beverages",
                  child: Text("Food and Beverages"),
                ),
                DropdownMenuItem(
                  value: "Clothing and Accessories",
                  child: Text("Clothing and Accessories"),
                ),
                DropdownMenuItem(
                  value: "Health and Hygiene",
                  child: Text("Health and Hygiene"),
                ),
                DropdownMenuItem(
                  value: "Home and Living",
                  child: Text("Home and Living"),
                ),
                DropdownMenuItem(
                  value: "Electronics and Technology",
                  child: Text("Electronics and Technology"),
                ),
                DropdownMenuItem(
                  value: "Entertainment and Hobbies",
                  child: Text("Entertainment and Hobbies"),
                ),
                DropdownMenuItem(value: "Others", child: Text("Others")),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a category';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addItem,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                elevation: 2,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Add Item",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
