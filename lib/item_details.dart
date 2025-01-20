import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  final Map<String, String>? item;
  final Function(Map<String, String>)? onSave;const ItemDetails({Key? key, this.item, this.onSave});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final TextStyle textStyle = const TextStyle(fontSize: 16.0);

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      titleController.text = widget.item!['title'] ?? '';
      descriptionController.text = widget.item!['description'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Project"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: textStyle,
              onChanged: (value) {
                debugPrint('Title changed: $value');
              },
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              style: textStyle,
              onChanged: (value) {
                debugPrint('Description changed: $value');
              },
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      foregroundColor: Theme.of(context).primaryColorLight,
                    ),
                    child: const Text('Save', textScaleFactor: 1.5),
                    onPressed: () {
                      debugPrint("Save button clicked");
                      // Create a map to store the item data
                      Map<String, String> newItem = {
                        'title': titleController.text,
                        'description': descriptionController.text,
                      };
                      if (widget.onSave != null) {
                        widget.onSave!(newItem);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      foregroundColor: Theme.of(context).primaryColorLight,
                    ),
                    child: const Text('Delete', textScaleFactor: 1.5),
                    onPressed: () {
                      debugPrint("Delete button clicked");
                      titleController.clear();
                      descriptionController.clear();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}