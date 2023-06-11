import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button functionality
        return false;
      },
      child: AlertDialog(
        title: Text('Custom Popup'),
        content: Text('This popup cannot be dismissed.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Handle button press
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
