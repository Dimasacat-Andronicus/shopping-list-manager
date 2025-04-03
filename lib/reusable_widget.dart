import 'package:flutter/material.dart';

void promptDialog(context, content, listName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "Success",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        content: Text(
          "The item \"$listName\" $content successfully!",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2.0),
              child: Text(
                "Close",
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
