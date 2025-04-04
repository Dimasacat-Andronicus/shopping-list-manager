import 'package:crud_flutter_shopping/shopping_list_class.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'add_item.dart';
import 'list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF546E7A),
          secondary: Color(0xFFF0F4F8),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = ListPage();
      case 1:
        page = AddItemPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Shopping List",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        actions: [
          IconButton(
            onPressed: () {
              for (var item = 0; item < ListData.itemList.length; item++) {
                if (kDebugMode) {
                  print(
                    "${ListData.itemList[item].name}, "
                    "${ListData.itemList[item].quantity}, "
                    "${ListData.itemList[item].brand}",
                  );
                }
              }
            },
            icon: Icon(Icons.check_circle_outline, color: Color(0xFFF0F4F8)),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.list_alt),
                        label: 'Item List',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.add),
                        label: 'Add Item',
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.list_alt),
                        label: Text('Item List'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.add),
                        label: Text('Add Item'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}
