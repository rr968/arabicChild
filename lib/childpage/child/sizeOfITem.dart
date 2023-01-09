


import 'package:arabic_speaker_child/childpage/child/childFirstInfo.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


import '../../controller/var.dart';

class NumofItems extends StatefulWidget {
  const NumofItems({Key? key}) : super(key: key);

  @override
  State<NumofItems> createState() => _NumofItemsState();
}

class _NumofItemsState extends State<NumofItems> {
  int Itemsnum = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
          children:[ Container(

            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/uiImages/bg.png"),
                    fit: BoxFit.cover)),
          ),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SafeArea(
                child: Center(
                  child:
                  Expanded(
                    child: Container(
                      height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * .70
                          : MediaQuery.of(context).size.height * .100,
                      width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width * .7
                          : MediaQuery.of(context).size.width * .45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xff989999), width: 2),
                          borderRadius: BorderRadius.circular(40)),
                      child:Padding(padding: const EdgeInsets.all(2),
                        child: Column(
                            children: [

                          Container(
                            height: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              "اختر الحجم \nالأيقونات المناسب",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 50,
                                color: maincolor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Container(
                            height:  MediaQuery.of(context).orientation == Orientation.portrait?22:20,
                          ),
                          Text(
                            "يمكنك التعديل لاحقا",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: greyColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(40),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey),
                                color: Color.fromARGB(
                                    255, 255, 255, 255)
                                    .withOpacity(0.8),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(60)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: Offset(0, 3)),
                                ],
                              ),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [


                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height:  MediaQuery.of(context).orientation == Orientation.portrait
                                                    ?100:50,
                                                width: MediaQuery.of(context).orientation == Orientation.portrait?50:20,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage("assets/uiImages/bigBox.png"),
                                                        fit: BoxFit.fill)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top:2),
                                                child: Container(
                                                  height: 20,
                                                  width:50,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage("assets/uiImages/horBig.png"),
                                                          fit: BoxFit.fill)),
                                                ),
                                              ),
                                            ],

                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 3.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width:50,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage("assets/uiImages/bigBox.png"),
                                                          fit: BoxFit.fill)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top:2),
                                                  child: Container(
                                                    height: 20,
                                                    width:50,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage("assets/uiImages/horBig.png"),
                                                            fit: BoxFit.fill)),
                                                  ),
                                                ),
                                              ],

                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 60),
                                            child: Center(
                                              child: Lottie.asset("assets/15-ratio-outline (1).json",
                                                width: 150,
                                                height: 150,
                                                fit: BoxFit.fill,),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(left:60),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width:50,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage("assets/uiImages/boxSmall.png"),
                                                          fit: BoxFit.fill)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top:5),
                                                  child: Container(
                                                    height: 50,
                                                    width:50,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage("assets/uiImages/boxSmall.png"),
                                                            fit: BoxFit.fill)),
                                                  ),
                                                ),
                                              ],

                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 3.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width:50,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage("assets/uiImages/boxSmall.png"),
                                                          fit: BoxFit.fill)),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(top:2),
                                                  child: Container(
                                                    height: 50,
                                                    width:50,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage("assets/uiImages/boxSmall.png"),
                                                            fit: BoxFit.fill)),
                                                  ),
                                                ),
                                              ],

                                            ),
                                          ),


                                        ],
                                      ),


                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Slider(
                                            onChanged: (value) {
                                              setState(() {
                                                Itemsnum = value.toInt();
                                              });
                                            },
                                            value: Itemsnum.toDouble(),
                                            max: 2,
                                            min: 1,
                                            divisions: 3,
                                            label: Itemsnum.toString(),
                                            activeColor: Color.fromARGB(
                                                220, 220, 220, 220)
                                                .withOpacity(0.8),
                                            //inactiveColor: Colors.orangeAccent,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("كبير", style: TextStyle(
                                            fontSize: 24,
                                          ),),

                                          Padding(padding: const EdgeInsets.only(
                                              right: 10 ),
                                            child: Text("عادي", style: TextStyle(
                                              fontSize: 24,
                                            ),
                                            ),
                                          ),
                                        ],

                                      ),
                                    ),


                                  ],
                                ),


                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) => const Selectedlib()),
                                          (route) => false),

                                  child: Image.asset(
                                    "assets/uiImages/next.png",
                                    height: 85,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ]),

                      ),
                    ),
                  ),




                ),
              ),
            ),
          ]
      ),
    );
  }
}
