import '/controller/var.dart';
import '/view/export_and_import/exportcontent.dart';
import 'package:flutter/material.dart';

import '../../controller/images.dart';
import '../../model/library.dart';

class ExportLibrary extends StatelessWidget {
  final List<lib> data;
  const ExportLibrary({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          title: const Text(" محتوى المكتبة",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                //fontWeight: FontWeight.bold
              )),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 10),
          child: GridView.builder(
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExportContent(
                                content: data[index].contenlist)));
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: maincolor, width: 1.5),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(children: [
                        const SizedBox(
                          height: 7,
                        ),
                        Expanded(child: getImage(data[index].imgurl)),
                        Text(
                          data[index].name,
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
