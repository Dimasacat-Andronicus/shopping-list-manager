import 'package:crud_flutter_shopping/reusable_widget.dart';

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
                          if (numValue == null || numValue <= 0 || numValue > 999999) {
                            quantityController.text = value.substring(0, value.length - 1);
                          }
                        }
                      }
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
                            );
                            Navigator.of(context).pop();
                            promptDialog(context, content);
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
  ) {
    setState(() {
      ListData.itemList[index].name = newName;
      ListData.itemList[index].quantity = newQuantity;
      ListData.itemList[index].brand = newBrand;
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
            "Do you want to remove permanently?",
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
                backgroundColor:
                Theme.of(context).colorScheme.primary,
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child:
                  ListData.itemList.isEmpty
                      ? Center(
                        child: Text(
                          "No items in the list",
                          style: TextStyle(color: Color(0xFF546E7A)),
                        ),
                      )
                      : ListView.builder(
                        itemCount: ListData.itemList.length,
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
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                title: Text(
                                  ListData.itemList[index].name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF546E7A),
                                  ),
                                ),
                                subtitle: Text(
                                  (ListData.itemList[index].quantity.isNotEmpty
                                          ? "Quantity: ${ListData.itemList[index].quantity}\n"
                                          : "") +
                                      (ListData.itemList[index].brand.isNotEmpty
                                          ? "Brand: ${ListData.itemList[index].brand}"
                                          : ""),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF546E7A),
                                  ),
                                ),
                                isThreeLine:
                                    ListData
                                        .itemList[index]
                                        .quantity
                                        .isNotEmpty ||
                                    ListData.itemList[index].brand.isNotEmpty,
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
                                      onPressed: () => _showEditDialog(index),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      ),
                                      onPressed: () => _showRemoveDialog(index),
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
