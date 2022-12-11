import 'package:provider/provider.dart';

import '../../../controller/my_provider.dart';
import '/controller/var.dart';
import 'package:flutter/material.dart';

import '../../../controller/icons.dart';

class AddIcon extends StatefulWidget {
  final int groupindex;
  const AddIcon({Key? key, required this.groupindex}) : super(key: key);

  @override
  State<AddIcon> createState() => _AddIconState();
}

class _AddIconState extends State<AddIcon> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          ///// title: Text(
          title: Text(" ${iconsList[widget.groupindex].name}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
        ),
        body: ListView(children: [
          const SizedBox(
            height: 21,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  110,
              child: GridView.builder(
                  itemCount: iconsList[widget.groupindex].contenlist.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 23,
                    crossAxisSpacing: 23,
                  ),
                  itemBuilder: ((context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Provider.of<MyProvider>(context, listen: false)
                              .setPath(iconsList[widget.groupindex]
                                  .contenlist[index]
                                  .imgurl);
                        },
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
                                  iconsList[widget.groupindex]
                                      .contenlist[index]
                                      .imgurl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  iconsList[widget.groupindex]
                                      .contenlist[index]
                                      .name,
                                  style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                ),
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
