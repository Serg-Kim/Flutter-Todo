import 'package:flutter/material.dart';

class TodoDialog {
  static Future<String?> displayDialog(BuildContext context, bool isAdd) {
    late String title = isAdd == true ? 'Add a Todo' : 'Edit a Todo';
    late String buttonText = isAdd == true ? 'Add' : 'Edit';

    final TextEditingController textFieldController = TextEditingController();

    return showDialog<String?>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              controller: textFieldController,
              decoration: const InputDecoration(hintText: 'Type your todo'),
              autofocus: true,
            ),
            actions: <Widget>[
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  textFieldController.clear();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .inversePrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(textFieldController.text
                  );
                  textFieldController.clear();
                },
                child: Text(
                    buttonText, style: const TextStyle(color: Colors.white)),
              ),
            ],
          );
        }
    );
  }
}