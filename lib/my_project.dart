import 'package:flutter/material.dart';
import 'dart:math';
import 'item_details.dart';

class MyProject extends StatefulWidget {
  @override
  State<MyProject> createState() => MyProjectState();
}

class MyProjectState extends State<MyProject> {
List<Map<String, String>> items = [];
final List<Color> _itemColors = [
  Colors.red.shade100,
  Colors.blue,
  Colors.green,
  Colors.yellow.shade100,
  Colors.purple,
  Colors.pink,
  Colors.teal.shade100,
  Colors.indigo,
  Colors.cyan,
  Colors.deepOrange.shade100,
  Colors.purpleAccent.shade100,
];
final Random _random = Random();

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 10),
      child: AppBar(
        title: const Text(
          'My Project',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 4,
        actions: const [
        ],
      ),
    ),
    body: items.isEmpty
        ? const Center(child: Text('No items yet!'))
        : getItemListView(),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemDetails(
            onSave: (item) {
              setState(() {
                items.add(item);
              });
            },
          ),
          ),
        );
      },
      tooltip: 'Add Item',
      child: const Icon(Icons.add),
    ),

  );
}

Widget getItemListView() {
  TextStyle textStyle = Theme.of(context).textTheme.headlineMedium!;
  return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int position) {
        final Color itemColor = _itemColors[_random.nextInt(_itemColors.length)];
        final item = items[position];
        return Card(
          color: itemColor.withOpacity(0.7),
          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: itemColor,
              child: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Item ${position + 1}: ${item['title']}',
              style: textStyle,
            ),
            subtitle: Text(
              'Description: ${item['description']}',
              style: textStyle,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  items.removeAt(position);
                });
              },
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => ItemDetails(
                item: item,
                onSave: (item) {
                  setState(() {
                    items.add(item);
                  });
                },
              ),
                  ));
            },
          ),
        );
      });
}
}