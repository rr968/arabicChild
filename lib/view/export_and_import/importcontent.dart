import 'package:arabic_speaker_child/childpage/child/speakingchildtablet.dart';
import 'package:arabic_speaker_child/controller/istablet.dart';

import '/controller/var.dart';
import '/model/content.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../controller/images.dart';
import '../../controller/speak.dart';

// ignore: must_be_immutable
class ImportContent extends StatefulWidget {
  final List<Content> content;
  const ImportContent({Key? key, required this.content}) : super(key: key);

  @override
  State<ImportContent> createState() => _ImportContentState();
}

class _ImportContentState extends State<ImportContent> {
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? DeviceUtil.isTablet
                            ? 4
                            : 3
                        : 5,
                childAspectRatio: 1,
                mainAxisSpacing: DeviceUtil.isTablet ? 20 : 12,
                crossAxisSpacing: DeviceUtil.isTablet ? 20 : 7,
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
                        howtospeak(widget.content[index].name, context);

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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          const SizedBox(
                            height: 7,
                          ),
                          Expanded(
                              child: getImage(widget.content[index].imgurl)),
                          Container(
                            height: 4,
                          ),
                          Text(
                            noMoreText(widget.content[index].name),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 23 : 18,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                      )),
                );
              })),
        ),
      ),
    );
  }
}
