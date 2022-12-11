import '/controller/var.dart';
import 'package:flutter/material.dart';

Container buttonlib(Widget ch, f) {
  return Container(
    width: 110,
    height: 75,
    decoration: BoxDecoration(
        color: maincolor, borderRadius: BorderRadius.circular(10)),
    child: InkWell(onTap: f, child: Center(child: ch)),
  );
}
