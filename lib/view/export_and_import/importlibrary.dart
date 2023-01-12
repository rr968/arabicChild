import '/controller/var.dart';
import 'importcontent.dart';
import 'package:flutter/material.dart';

import '../../controller/images.dart';
import '../../model/library.dart';

class ImportLibrary extends StatelessWidget {
  final List<lib> data;
  const ImportLibrary({Key? key, required this.data}) : super(key: key);

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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 5
                        : 7,
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
                            builder: (context) => ImportContent(
                                content: data[index].contenlist)));
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: maincolor, width: 1.5),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Column(children: [
                          Expanded(child: getImage(data[index].imgurl)),
                          Container(
                            height: 4,
                          ),
                          Text(
                            data[index].name,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
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
