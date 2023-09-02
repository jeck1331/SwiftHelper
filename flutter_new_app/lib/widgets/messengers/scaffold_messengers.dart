import 'package:flutter/material.dart';

class ScaffoldMessengers {
  final SnackBar error = SnackBar(
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.all(8),
        height: 40,
        child: const Center(
          child: Text('Ошибка!'),
        ),
      ));

  SnackBar errorMessage(String errorText) {
    return SnackBar(
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        content: Container(
            padding: const EdgeInsets.all(8),
            height: 70,
            child: Center(
              child: Text(errorText),
            )
        )
    );
  }

  final SnackBar success = SnackBar(
      backgroundColor: Colors.greenAccent,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.all(8),
        height: 40,
        child:  const Center(
          child: Text('Успешно!'),
        )
      )
  );

  SnackBar info(String infoText) {
    return SnackBar(
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        content: Container(
            padding: const EdgeInsets.all(8),
            height: 40,
            child: Center(
              child: Text(infoText),
            )
        )
    );
  }
}