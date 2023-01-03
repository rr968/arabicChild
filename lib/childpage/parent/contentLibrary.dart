// ignore_for_file: use_build_context_synchronously, camel_case_types, file_names

import 'package:arabic_speaker_child/childpage/child/speakingchildtablet.dart';

import '/childpage/parent/addContentChild.dart';
import '/childpage/parent/mainparent.dart';
import '/childpage/parent/rearrangeContentChild.dart';
import '/controller/images.dart';
import '/controller/istablet.dart';
import '/controller/speak.dart';
import '/controller/var.dart';
import '/model/library.dart';
import '/view/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/libtostring.dart';
import '../../controller/my_provider.dart';

class contentLibraryChild extends StatefulWidget {
  final int libIndex;
  const contentLibraryChild({super.key, required this.libIndex});

  @override
  State<contentLibraryChild> createState() => _contentLibraryChildState();
}

class _contentLibraryChildState extends State<contentLibraryChild> {
  List isSelected = [];
  bool selectedAvaiabel = false;
  final controllerList = ScrollController();
  double currentOffsetScroll = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const Drawerc(),
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Align(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                child: const SizedBox(
                  height: 70,
                  width: 70,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 55,
                    ),
                  ),
                ),
                onTap: () {
                  Provider.of<MyProvider>(context, listen: false)
                      .setIscontentOfLibrary(-1);
                },
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: !selectedAvaiabel
                  ? Text(
                      libraryListChild[widget.libIndex].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: purcolor,
                          fontSize: DeviceUtil.isTablet ? 45 : 26,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      "حذف جملة",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: purcolor,
                          fontSize: DeviceUtil.isTablet ? 45 : 26,
                          fontWeight: FontWeight.bold),
                    ),
            ),
            selectedAvaiabel
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            if (libraryListChild[widget.libIndex]
                                .contenlist
                                .isNotEmpty) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReArrangeContentChild(
                                              contentIndex: widget.libIndex)),
                                  (route) => false);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                                color: purcolor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.low_priority,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  Container(
                                    width: 7,
                                  ),
                                  const Text(
                                    "إعادة ترتيب",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddContentChild(
                                        libraryindex: widget.libIndex)));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: greenColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Container(
                                    width: 7,
                                  ),
                                  const Text(
                                    "إضافة جملة",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSelected = [];
                              selectedAvaiabel = true;
                            });
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: pinkColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.delete_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Container(
                                    width: 7,
                                  ),
                                  const Text(
                                    "حذف جملة",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 70,
                height: MediaQuery.of(context).size.height * .5,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 202, 202, 202)),
                  color:
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(27)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 217, 216, 216)
                          .withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 7,
                    )
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [
                      libraryListChild[widget.libIndex].contenlist.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "لم يتم إضافة أي جملة بعد ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                            )
                          : Expanded(
                              child: GridView.builder(
                                  controller: controllerList,
                                  scrollDirection: Axis.vertical,
                                  itemCount: libraryListChild[widget.libIndex]
                                      .contenlist
                                      .length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 4
                                              : 5,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 20,
                                          childAspectRatio: 1 / 1),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        if (selectedAvaiabel) {
                                          if (isSelected.contains(index)) {
                                            setState(() {
                                              isSelected.remove(index);
                                            });
                                          } else {
                                            setState(() {
                                              isSelected.add(index);
                                            });
                                          }
                                        } else {
                                          String pathCache =
                                              libraryListChild[widget.libIndex]
                                                  .contenlist[index]
                                                  .cacheVoicePath;

                                          if (pathCache.isNotEmpty) {
                                            final player = AudioPlayer();

                                            await player.setFilePath(pathCache);

                                            player.play();
                                          } else {
                                            howtospeak(libraryListChild[
                                                    widget.libIndex]
                                                .contenlist[index]
                                                .name);
                                          }
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                      255, 255, 255, 255)
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(27)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 3,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 3)),
                                              ],
                                              border: Border.all(
                                                width: 2,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: getImage(
                                                        libraryListChild[
                                                                widget.libIndex]
                                                            .contenlist[index]
                                                            .imgurl)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5,
                                                          left: 8,
                                                          right: 8),
                                                  child: Text(
                                                    noMoreText(libraryListChild[
                                                            widget.libIndex]
                                                        .contenlist[index]
                                                        .name),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          !selectedAvaiabel
                                              ? Container()
                                              : isSelected.contains(index)
                                                  ? Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                        height:
                                                            DeviceUtil.isTablet
                                                                ? 34
                                                                : 25,
                                                        width:
                                                            DeviceUtil.isTablet
                                                                ? 34
                                                                : 25,
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                224,
                                                                223,
                                                                223),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.red,
                                                                width: 3)),
                                                        child: Icon(
                                                          Icons.circle,
                                                          color: Colors.red,
                                                          size: DeviceUtil
                                                                  .isTablet
                                                              ? 25
                                                              : 18,
                                                        ),
                                                      ),
                                                    )
                                                  : Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                        height:
                                                            DeviceUtil.isTablet
                                                                ? 34
                                                                : 25,
                                                        width:
                                                            DeviceUtil.isTablet
                                                                ? 34
                                                                : 25,
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                224,
                                                                223,
                                                                223),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40),
                                                            border: Border.all(
                                                                color:
                                                                    Colors.red,
                                                                width: 3)),
                                                      ),
                                                    ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            !selectedAvaiabel
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 40, top: 20, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            List theSelectedItem = isSelected;
                            theSelectedItem.sort();
                            theSelectedItem = theSelectedItem.reversed.toList();
                            for (var element in theSelectedItem) {
                              libraryListChild[widget.libIndex]
                                  .contenlist
                                  .removeAt(element);
                            }

                            SharedPreferences liblist =
                                await SharedPreferences.getInstance();
                            List<String> v = [];
                            for (lib l in libraryListChild) {
                              String s = convertLibString(l);
                              v.add(s);
                            }
                            liblist.setStringList("liblistChild", v);
                            Provider.of<MyProvider>(context, listen: false)
                                .setIscontentOfLibrary(widget.libIndex);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainParentPage(
                                          index: 0,
                                        )),
                                (route) => false);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: greenColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "  حفظ  ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedAvaiabel = false;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: pinkColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "  إلغاء  ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
