import 'package:crud_flutter_shopping/reusable_widget.dart';
import 'package:flutter/services.dart';
import 'shopping_list_class.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

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
      home: ListDisplay(),
    );
  }
}

class ListDisplay extends StatefulWidget {
  const ListDisplay({super.key});

  @override
  State<ListDisplay> createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  final title = "Edit Item";
  final content = "updated";
  TextEditingController searchController = TextEditingController();

  void _showEditDialog(int index) {
    TextEditingController nameController = TextEditingController(
      text: ListData.itemList[index].name,
    );
    TextEditingController quantityController = TextEditingController(
      text: ListData.itemList[index].quantity,
    );
    TextEditingController brandController = TextEditingController(
      text: ListData.itemList[index].brand,
    );
    TextEditingController priceController = TextEditingController(
      text: ListData.itemList[index].price.toString(),
    );
    String editSelectedCategory = ListData.filteredList[index].category;

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Edit Item",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Item Name *",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      prefixIcon: Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.grey.shade600,
                      ),
                      errorText:
                          nameController.text.isEmpty ? "Required" : null,
                    ),
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      labelText: "Quantity (optional)",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
                        if (numValue == null ||
                            numValue <= 0 ||
                            numValue > 999999) {
                          quantityController.text = value.substring(
                            0,
                            value.length - 1,
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: brandController,
                    decoration: InputDecoration(
                      labelText: "Brand (optional)",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      prefixIcon: Icon(
                        Icons.label_outline,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: priceController,
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
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                      DecimalTextInputFormatter(decimalRange: 2),
                    ],
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: editSelectedCategory,
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
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        editSelectedCategory = value!;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey.shade600,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Cancel", style: TextStyle(fontSize: 16)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty) {
                            _editItem(
                              index,
                              nameController.text,
                              quantityController.text,
                              brandController.text,
                              double.tryParse(priceController.text) ?? 0.0,
                              editSelectedCategory,
                            );
                            Navigator.of(context).pop();
                            promptDialog(context, content, nameController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 2.0,
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _editItem(
    int index,
    String newName,
    String newQuantity,
    String newBrand,
    double newPrice,
    String newCategory,
  ) {
    setState(() {
      ListData.itemList[index].name = newName;
      ListData.itemList[index].quantity = newQuantity;
      ListData.itemList[index].brand = newBrand;
      ListData.itemList[index].price = newPrice;
      ListData.itemList[index].category = newCategory;
    });
  }

  void _showRemoveDialog(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            "Remove",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          content: Text(
            "Do you want to remove \"${ListData.itemList[index].name}\" permanently?",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          actions: [
            TextButton(
              child: Text(
                "Close",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () {
                _removeItem(index);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 1.0,
                  horizontal: 2.0,
                ),
                child: Text(
                  "Delete",
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

  void _removeItem(int index) {
    setState(() {
      ListData.itemList.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    ListData.filteredList = ListData.itemList;
  }

  void _filterList(String query) {
    setState(() {
      query = query.trim();
      if (query.isEmpty) {
        ListData.filteredList = ListData.itemList;
      } else {
        ListData.filteredList =
            ListData.itemList.where((item) {
              return item.name.toLowerCase().contains(query.toLowerCase()) ||
                  item.brand.toLowerCase().contains(query.toLowerCase()) ||
                  item.category.toLowerCase().contains(query.toLowerCase());
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ListData.itemList.isEmpty
              ? Center(
                child: Text(
                  "No items in the list",
                  style: TextStyle(color: Color(0xFF546E7A)),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                labelText: "Search",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              onChanged: _filterList,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child:
                          ListData.filteredList.isEmpty
                              ? Center(
                                child: Text(
                                  "No results found",
                                  style: TextStyle(color: Color(0xFF546E7A)),
                                ),
                              )
                              : ListView.builder(
                                itemCount: ListData.filteredList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Card(
                                      elevation: 6,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        tileColor: Color(0xFFF0F4F8),
                                        contentPadding: EdgeInsets.all(5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        title: Text(
                                          ListData.filteredList[index].name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF546E7A),
                                          ),
                                        ),
                                        subtitle: Text(
                                          "${ListData.filteredList[index].quantity.isNotEmpty ? "Quantity: ${ListData.filteredList[index].quantity}\n" : ""}"
                                          "${ListData.filteredList[index].brand.isNotEmpty ? "Brand: ${ListData.filteredList[index].brand}\n" : ""}"
                                          "${ListData.filteredList[index].price > 0 ? "Price: ₱${ListData.filteredList[index].price}\n" : ""}"
                                          "${ListData.filteredList[index].category.isNotEmpty ? "Category: ${ListData.filteredList[index].category}" : ""}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF546E7A),
                                          ),
                                        ),
                                        isThreeLine: true,
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                              ),
                                              onPressed:
                                                  () => _showEditDialog(index),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                              ),
                                              onPressed:
                                                  () =>
                                                      _showRemoveDialog(index),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              ),
    );
  }
}
