// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:async';

import 'dart:io' as io;
import '/childpage/parent/mainparent.dart';
import '/controller/my_provider.dart';
import 'package:provider/provider.dart';
import '/controller/var.dart';

import '../../controller/erroralert.dart';
import '../../controller/images.dart';
import '../../icon/iconsgroup.dart';
import '/model/content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/button.dart';
import '../../controller/libtostring.dart';
import '../../model/library.dart';

class AddContentChild extends StatefulWidget {
  final int libraryindex;
  const AddContentChild({Key? key, required this.libraryindex})
      : super(key: key);

  @override
  State<AddContentChild> createState() => _AddContentChildState();
}

class _AddContentChildState extends State<AddContentChild> {
  FlutterAudioRecorder2? _recorder;
  Recording? _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool isRecording = false;
  late var im;
  TextEditingController controller = TextEditingController();
  bool isReady = false;
  String optionalvoice = "";
  bool isrecodeNow = false;
  bool deleteColor = false;
  bool errorsen = false;
  String message = "  سيتم نطق الجملة بواسطة المتحدث العربي    ";
  bool hint = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MyProvider>(context, listen: false).setPath("");
    });
    initrecorder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: Text(
                "إضافة جملة",
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                    color: maincolor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 22),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: greyColor, width: 1),
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 255, 255,
                            255) // Color.fromARGB(255, 121, 161, 134)
                        .withOpacity(.4)),
                child: Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          height: 97,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              if (controller.text.isNotEmpty) {
                                setState(() {
                                  errorsen = false;
                                });
                              }
                            },
                            controller: controller,
                            maxLines: 3,
                            cursorColor: maincolor,
                            decoration: InputDecoration(
                              labelText: "اكتب جملة لا تتجاوز ست كلمات",
                              labelStyle: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: maincolor),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 123, 123, 123))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            optionalvoice.isEmpty
                                ? InkWell(
                                    onTap: () async {
                                      setState(() {
                                        message =
                                            "سيتم نطق الجملة بواسطة الصوت الخاص بك";
                                      });
                                      if (_currentStatus ==
                                          RecordingStatus.Initialized) {
                                        _start();
                                      } else if (_currentStatus ==
                                              RecordingStatus.Recording &&
                                          _currentStatus !=
                                              RecordingStatus.Unset) {
                                        _stop();
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: greyColor, width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color.fromARGB(255, 255, 255,
                                                  255) // Color.fromARGB(255, 121, 161, 134)
                                              .withOpacity(.4)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (_currentStatus ==
                                                RecordingStatus.Recording)
                                              const Icon(
                                                Icons.stop,
                                                size: 60,
                                                color: Colors.red,
                                              )
                                            else
                                              Icon(Icons.mic,
                                                  size: 60,
                                                  color: Color.fromARGB(
                                                      255, 132, 132, 132)),
                                            _currentStatus ==
                                                    RecordingStatus.Recording
                                                ? const Text(
                                                    "يتم التسجيل...",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                : Text(
                                                    "تسجيل صوتي",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 132, 132, 132),
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ))
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        message =
                                            "سيتم نطق الجملة بواسطة المتحدث العربي    ";
                                        optionalvoice = "";
                                      });
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: greyColor, width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color.fromARGB(255, 255, 255,
                                                  255) // Color.fromARGB(255, 121, 161, 134)
                                              .withOpacity(.4)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.restart_alt,
                                            color: Color.fromARGB(
                                                255, 132, 132, 132),
                                            size: 60,
                                          ),
                                          Text(
                                            "إلغاء التسجيل",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 132, 132, 132),
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            Provider.of<MyProvider>(context)
                                    .lastimagepath
                                    .toString()
                                    .isNotEmpty
                                ? InkWell(
                                    onTap: () => diag(),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 31),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: greyColor, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Color.fromARGB(255, 255, 255,
                                                    255) // Color.fromARGB(255, 121, 161, 134)
                                                .withOpacity(.4)),
                                        height: 100,
                                        width: 100,
                                        child: getImage(
                                            Provider.of<MyProvider>(context)
                                                .lastimagepath
                                                .toString()),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Container(
                              width: 30,
                            ),
                            Provider.of<MyProvider>(context)
                                    .lastimagepath
                                    .toString()
                                    .isEmpty
                                ? InkWell(
                                    onTap: () => diag(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: greyColor, width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color.fromARGB(255, 255, 255,
                                                  255) // Color.fromARGB(255, 121, 161, 134)
                                              .withOpacity(.4)),
                                      height: 100,
                                      width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add_a_photo,
                                              color: Color.fromARGB(
                                                  255, 132, 132, 132),
                                              size: 60,
                                            ),
                                            Text(
                                              "صورة",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 132, 132, 132),
                                                  fontWeight: FontWeight.w800),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Container(
                              width: 30,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    deleteColor = true;
                                  });
                                  Future.delayed(const Duration(seconds: 1))
                                      .then((value) {
                                    setState(() {
                                      deleteColor = false;
                                    });
                                  });
                                  controller.clear();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: greyColor, width: 1.5),
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color.fromARGB(255, 255, 255,
                                              255) // Color.fromARGB(255, 121, 161, 134)
                                          .withOpacity(.4)),
                                  height: 100,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.delete_outline,
                                          color: deleteColor
                                              ? Colors.red
                                              : Color.fromARGB(
                                                  255, 132, 132, 132),
                                          size: 60,
                                        ),
                                        Text(
                                          "مسح",
                                          style: TextStyle(
                                              color: deleteColor
                                                  ? Colors.red
                                                  : Color.fromARGB(
                                                      255, 132, 132, 132),
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ///////////
            hint
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 3, right: 33, bottom: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 238, 237, 237),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  hint = false;
                                });
                              },
                              child: const Icon(Icons.close),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: maincolor,
                                size: 16,
                              ),
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          Container(
                            height: 18,
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
            ///////////////////
            errorsen
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 3, right: 33, bottom: 10),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        const Text(
                          " يجب ادخال جملة  ",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            Container(
              height: 15,
            ),
            SizedBox(
              height: 65,
              width: 220,
              child: InkWell(
                onTap: () async {
                  if (controller.text.trim().isEmpty) {
                    setState(() {
                      errorsen = true;
                    });
                  } else {
                    String imgUpload = "no";
                    String voiceUpload = "no";
                    if (Provider.of<MyProvider>(context, listen: false)
                            .lastimagepath
                            .toString()
                            .isEmpty ||
                        Provider.of<MyProvider>(context, listen: false)
                            .lastimagepath
                            .toString()
                            .contains("assets/")) {
                      imgUpload = "yes";
                    }
                    if (optionalvoice.isEmpty) voiceUpload = "yes";

                    libraryListChild[widget.libraryindex].contenlist.add(
                        Content(
                            controller.text,
                            Provider.of<MyProvider>(context, listen: false)
                                .lastimagepath
                                .toString(),
                            imgUpload,
                            optionalvoice,
                            optionalvoice,
                            voiceUpload));
                    SharedPreferences liblist =
                        await SharedPreferences.getInstance();
                    List<String> v = [];
                    for (lib l in libraryListChild) {
                      String s = convertLibString(l);
                      v.add(s);
                    }
                    liblist.setStringList("liblistChild", v);
                    //tryUploadData();
                    Provider.of<MyProvider>(context, listen: false)
                        .setIscontentOfLibrary(widget.libraryindex);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainParentPage(
                                  index: 0,
                                )),
                        (route) => false);

                    Provider.of<MyProvider>(context, listen: false).setPath("");
                    // acceptalert(context, "تم إضافة المحتوى بنجاح");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'حفظ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  initrecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
    } else {
      _init();
    }
  }

  _init() async {
    try {
      bool hasPermission = await FlutterAudioRecorder2.hasPermissions ?? false;

      if (hasPermission) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = (await getExternalStorageDirectory())!;
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder2(customPath, audioFormat: AudioFormat.WAV);

        await _recorder!.initialized;
        // after initialization
        var current = await _recorder!.current(channel: 0);
        setState(() {
          _current = current;
          _currentStatus = current!.status!;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You must accept permissions")));
      }
    } catch (_) {}
  }

  _start() async {
    try {
      await _recorder!.start();
      var recording = await _recorder!.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = Duration(milliseconds: 50);
      Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder!.current(channel: 0);
        if (mounted) {
          setState(() {
            _current = current;
            _currentStatus = _current!.status!;
          });
        }
      });
    } catch (_) {}
  }

  _stop() async {
    var result = await _recorder!.stop();
    final player = AudioPlayer();

    if (result?.path != null) {
      optionalvoice = result?.path ?? "";
      await player.setFilePath(result?.path ?? "");
      player.play();
    }
    _init();
    setState(() {
      _current = result;
      _currentStatus = _current!.status!;
    });
  }

  Future pickimage(ImageSource source) async {
    try {
      final im = await ImagePicker().pickImage(source: source);
      if (im == null) {
        return;
      } else {
        Provider.of<MyProvider>(context, listen: false).setPath(im.path);
      }
    } on PlatformException {
      ///////////edit heeeeeeeeeeeeeeeeeeeeeeeeere
      return;
    }
  }

  diag() {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                  child: const Text(
                    "الكاميرا",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    pickimage(ImageSource.camera);
                  }),
              CupertinoDialogAction(
                child: const Text(" الاستديو",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                  pickimage(ImageSource.gallery);
                },
              ),
              CupertinoDialogAction(
                child: const Text("مكتبة الايقونات",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Icongroups()));
                },
              ),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('إلغاء',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold))),
            ],
          );
        });
  }
}
