

import 'package:flutter/material.dart';

Text buildLabelWidget(String label) {
  return Text(
    label,
    style: new TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text buildMainLabelWidget(String label) {
  return Text(
    label,
    style: new TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.blue),
  );
}