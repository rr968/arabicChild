import 'dart:io';

import '/controller/var.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

getImage(String url) {
  if (url.isEmpty) {
    return Container();
  } else if (url.contains("assets/")) {
    return Image.asset(
      url,
      fit: BoxFit.fill,
    );
  } else if (url.contains("https://firebasestorage.googleapis.com")) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.fill,
      placeholder: (context, u) =>
          FittedBox(child: CircularProgressIndicator(color: maincolor)),
      errorWidget: (context, u, error) =>
          Container(color: Colors.red, child: const Icon(Icons.error)),
    );
  } else {
    return Image.file(
      File(url),
      fit: BoxFit.fill,
    );
  }
}
