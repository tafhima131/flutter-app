import 'package:flutter/material.dart';
import 'dart:math';
import 'item_details.dart';

class AllProjects extends StatefulWidget {
  @override
  State<AllProjects> createState() => AllProjectsState();
}

class AllProjectsState extends State<AllProjects> {
  List<Map<String, String>> items = [];
  List<Map<String, String>> filteredItems = [];
  final List<Color> _itemColors = [
    Colors.red.shade100,
    Colors.blue,
    Colors.greenAccent,
    Colors.yellow.shade600,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.cyan.shade100,
    Colors.deepOrange.shade600,
    Colors.purpleAccent.shade100,
  ];
  final Random _random = Random();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(items);
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = items
          .where((item) =>
      item['title']!.toLowerCase().contains(query.toLowerCase()) ||
          item['description']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: AppBar(
          title: const Text(
            'All Projects',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.teal,
          centerTitle: true,
          elevation: 4,
          actions: [
            // Search Bar
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    onSearch: (String query) {
                      _filterItems(query);
                    },
                    items: items,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: filteredItems.isEmpty
          ? const Center(child: Text('No items yet!'))
          : getItemListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetails(
                onSave: (item) {
                  setState(() {
                    items.add(item);
                    filteredItems = List.from(items);
                    _filterItems(_searchController.text);
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
        itemCount: filteredItems.length,
        itemBuilder: (BuildContext context, int position) {
          final Color itemColor = _itemColors[_random.nextInt(_itemColors.length)];
          final item = filteredItems[position];
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
              ),subtitle: Text(
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
                    filteredItems = List.from(items);
                    _filterItems(_searchController.text);
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
                          filteredItems = List.from(items);
                          _filterItems(_searchController.text);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final Function(String) onSearch;
  final List<Map<String, String>> items;

  CustomSearchDelegate({required this.onSearch, required this.items});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            onSearch('');
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    final suggestions = items.where((item) {
      return item['title']!.toLowerCase().contains(query.toLowerCase()) ||
          item['description']!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion['title']!),
          subtitle: Text(suggestion['description']!),
          onTap: () {
            query = suggestion['title']!;
            onSearch(query);
            close(context, query);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = items.where((item) {
      return item['title']!.toLowerCase().contains(query.toLowerCase()) ||
          item['description']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion['title']!),
          subtitle: Text(suggestion['description']!),
          onTap: () {
            query = suggestion['title']!;
            onSearch(query);
            close(context, query);
          },
        );
      },
    );
  }
}