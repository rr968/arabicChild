import '/icon/addicon.dart';

import '/controller/var.dart';
import 'package:flutter/material.dart';

import '../../../controller/icons.dart';

class Icongroups extends StatelessWidget {
  const Icongroups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          title: const Text("مكتبة الايقونات",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  100,
              child: GridView.builder(
                  itemCount: iconsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 23,
                    crossAxisSpacing: 23,
                  ),
                  itemBuilder: ((context, index) {
                    return InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddIcon(groupindex: index))),
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: maincolor, width: 1.5),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(children: [
                              const SizedBox(
                                height: 7,
                              ),
                              Expanded(
                                child: Image.asset(
                                  iconsList[index].imgurl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                iconsList[index].name,
                                style: const TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              )
                            ])));
                  })),
            ),
          ),
        ]),
      ),
    );
  }
}
