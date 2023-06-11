import 'package:arabic_speaker_child/controller/var.dart';
import 'package:flutter/material.dart';

class EditFilesContent extends StatefulWidget {
  const EditFilesContent({super.key});

  @override
  State<EditFilesContent> createState() => _EditFilesContentState();
}

class _EditFilesContentState extends State<EditFilesContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pinkColor,
        ),
        body: Padding(
            padding: const EdgeInsets.only(right: 5, left: 5, top: 20),
            child: Container(
              height: MediaQuery.of(context).size.height * .6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(width: 2, color: greyColor)),
              child: Column(
                children: [
                  Row(
                    children: [],
                  )
                ],
              ),
            )));
  }
}
