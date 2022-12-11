import '/controller/var.dart';
import '/model/content.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../controller/images.dart';
import '../../controller/speak.dart';

// ignore: must_be_immutable
class ExportContent extends StatefulWidget {
  final List<Content> content;
  const ExportContent({Key? key, required this.content}) : super(key: key);

  @override
  State<ExportContent> createState() => _ExportContentState();
}

class _ExportContentState extends State<ExportContent> {
  bool cantPressed = false;
  int cantpressIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 10),
          child: GridView.builder(
              itemCount: widget.content.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () async {
                    if (!cantPressed) {
                      setState(() {
                        cantPressed = true;
                        cantpressIndex = index;
                      });
                      String path = widget.content[index].opvoice;
                      if (path.isNotEmpty) {
                        final player = AudioPlayer(); // Create a player
                        path.contains("https://firebasestorage.googleapis.com")
                            ? await player.setUrl(// Load a URL
                                path)
                            : await player.setFilePath(
                                // Load a URL
                                path); // Schemes: (https: | file: | asset: )
                        player.play().then((value) {
                          setState(() {
                            cantPressed = false;
                          });
                        });
                      } else {
                        howtospeak(widget.content[index].name);

                        Future.delayed(const Duration(milliseconds: 1500))
                            .then((value) {
                          setState(() {
                            cantPressed = false;
                          });
                        });
                      }
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: maincolor, width: 1.5),
                          color: cantPressed && cantpressIndex == index
                              ? Colors.orange
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(children: [
                        const SizedBox(
                          height: 7,
                        ),
                        Expanded(child: getImage(widget.content[index].imgurl)),
                        Text(
                          widget.content[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        )
                      ])),
                );
              })),
        ),
      ),
    );
  }
}
