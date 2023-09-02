import 'package:flutter/material.dart';

class TestModalWidget extends StatelessWidget {
  final String route;
  const TestModalWidget({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Маршрут категории'),
      content: Text(route),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Назад'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('Ок'),
        ),
      ],
    );
  }
}
