// ignore_for_file: use_build_context_synchronously, file_names

import 'package:arabic_speaker_child/controller/erroralert.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/istablet.dart';
import '../../controller/libtostring.dart';
import '../../model/content.dart';
import '../../model/library.dart';

import '../../controller/var.dart';
import 'mainchildPage.dart';

class Selectedlib extends StatefulWidget {
  const Selectedlib({Key? key}) : super(key: key);

  @override
  State<Selectedlib> createState() => _SelectedlibState();
}

class _SelectedlibState extends State<Selectedlib> {
  List<int> indexesChooese = [];
  int selectAl=0;
  List<lib> chooseLibrary = [
    lib("التحيات", "assets/1ss.png", "yes", [
      Content("كيف حالك؟ ", "assets/question.png", "yes", "", "", "yes"),
      Content("اهلا وسهلا ", "assets/waving-hand.png", "yes", "", "", "yes"),
      Content(
          "مرحبا حياك الله ", "assets/introduction.png", "yes", "", "", "yes"),
      Content("أنا بخير والحمدلله ", "assets/prayer.png", "yes", "", "", "yes"),
      Content("وعليكم السلام ", "assets/hello.png", "yes", "", "", "yes"),
      Content("سعدت بالحديث معك مع السلامة ", "assets/hello (1).png", "yes", "",
          "", "yes")
    ]),
    lib("العمل", "assets/2ss.png", "yes", [
      Content("أين مكتب العمل؟ ", "assets/location.png", "yes", "", "", "yes"),
      Content(
          "أريد السكرتير ", "assets/secretary (1).png", "yes", "", "", "yes"),
      Content("أنا ابحث عن عمل يناسبني ", "assets/wheelchair (1).png", "yes",
          "", "", "yes"),
      Content("هل انتهى الدوام ؟ ", "assets/expired.png", "yes", "", "", "yes"),
      Content("ماهي البيانات المطلوبة", "assets/requirement.png", "yes", "", "",
          "yes"),
      Content("كيف أخدمك ؟ ", "assets/manufacturing.png", "yes", "", "", "yes")
    ]),
    lib("السوق", "assets/3ss.png", "yes", [
      Content("كم سعر هذا؟", "assets/how-much.png", "yes", "", "", "yes"),
      Content("السعر مرتفع جدًا", "assets/money.png", "yes", "", "", "yes"),
      Content("هل لديكم فرع آخر؟", "assets/branch.png", "yes", "", "", "yes"),
      Content(
          "أريد خضراوات طازجة", "assets/vegetable.png", "yes", "", "", "yes"),
      Content("هل لديكم تخفيضات؟", "assets/tag.png", "yes", "", "", "yes"),
      Content(
          "أين أجد قسم الملابس؟", "assets/clothing.png", "yes", "", "", "yes"),
      Content("أريد أن تساعدني في الحصول على القطع في الرف المرتفع",
          "assets/stand.png", "yes", "", "", "yes"),
      Content("لقد سقط هذا مني أرجوك أحضره", "assets/bring-to-front.png", "yes",
          "", "", "yes"),
      Content("أريد أن أدفع المبلغ تفضل", "assets/money (1).png", "yes", "", "",
          "yes"),
      Content("أريد إرجاع هذا لأنه لا يناسبني", "assets/exchange.png", "yes",
          "", "", "yes")
    ]),
    lib("السفر", "assets/4ss.png", "yes", [
      Content("الأجواء معتدلة وممتعة هنا", "assets/happiness.png", "yes", "",
          "", "yes"),
      Content("أريد أن أحجز تذكرة", "assets/plane-ticket.png", "yes", "", "",
          "yes"),
      Content("أريد أن أسجل الحضور", "assets/note.png", "yes", "", "", "yes"),
      Content("أريد الحصول على تخفيض ذوي الاعاقة", "assets/flight.png", "yes",
          "", "", "yes"),
      Content("كم تكلفة السفر", "assets/budget.png", "yes", "", "", "yes"),
      Content("أبحث عن مساعد ليساعدني في اتمام سفري",
          "assets/customer-service.png", "yes", "", "", "yes"),
      Content(
          "هل بوابة الرحلة مفتوحة؟", "assets/gate.png", "yes", "", "", "yes"),
      Content("هذه أمتعتي أريدك أن تساعدني", "assets/travel-bag.png", "yes", "",
          "", "yes"),
      Content("شكرًا لك وأنا ممنون لك", "assets/IconLib/body/hands.png", "yes",
          "", "", "yes")
    ]),
    lib("المدرسة", "assets/5ss.png", "yes", [
      Content("أستاذ أنا لم أفهم هذه المسألة", "assets/hypothesis.png", "yes",
          "", "", "yes"),
      Content("أريد أن أحل هذه المسألة", "assets/problem (1).png", "yes", "",
          "", "yes"),
      Content("لقد انتهيت", "assets/tick.png", "yes", "", "", "yes"),
      Content(
          "أريد الخروج من الفصل", "assets/exit-door.png", "yes", "", "", "yes"),
      Content("كم درجة الاختبار؟", "assets/homework.png", "yes", "", "", "yes"),
      Content(
          "متى ينتهي الدوام؟", "assets/working-time.png", "yes", "", "", "yes"),
      Content("أريد أن تساعدني في كتابة عبارات جديدة لاستخدامها في المدرسة",
          "assets/skill.png", "yes", "", "", "yes"),
      Content(
          "إلى اللقاء، مع السلامة", "assets/goodbye.png", "yes", "", "", "yes"),
      Content("مسطرة", "assets/ruler.png", "yes", "", "", "yes"),
      Content("دباسة", "assets/stapler.png", "yes", "", "", "yes"),
      Content("ملصقات", "assets/stickers.png", "yes", "", "", "yes"),
      Content("مقص", "assets/sicssor.png", "yes", "", "", "yes"),
      Content("قلم رصاص", "assets/pencil.png", "yes", "", "", "yes"),
      Content("مقلمة", "assets/pincelCase.png", "yes", "", "", "yes"),
      Content("كرسي", "assets/seat.png", "yes", "", "", "yes"),
      Content("قلم", "assets/pen.png", "yes", "", "", "yes"),
      Content("معجم", "assets/dic.jpg", "yes", "", "", "yes"),
      Content("كتاب", "assets/book.png", "yes", "", "", "yes"),
      Content("ورق", "assets/paper.png", "yes", "", "", "yes"),
      Content("ممحاة", "assets/eraser.png", "yes", "", "", "yes"),
    ]),
    lib("المطعم", "assets/6ss.png", "yes", [
      Content(
          "كم سعر هذه الوجبة؟", "assets/inflation.png", "yes", "", "", "yes"),
      Content("هل لديكم توصيل للمنازل؟", "assets/home-delivery.png", "yes", "",
          "", "yes"),
      Content("أنا أستخدم برنامج على الهاتف للتواصل معك، فأرجو أن تتساعد معي",
          "assets/smartphone.png", "yes", "", "", "yes"),
      Content("الطعم لذيذ شكرًا", "assets/tasty.png", "yes", "", "", "yes"),
      Content("هل لديكم شبكة للدفع؟", "assets/mobile-payment.png", "yes", "",
          "", "yes"),
      Content("كم مجموع الطعام؟", "assets/hand.png", "yes", "", "", "yes"),
      Content("أريد الباقي لوسمحت", "assets/payment-method.png", "yes", "", "",
          "yes"),
      Content("أبحث عن مطعم شعبي قريب من هنا", "assets/restaurant (1).png",
          "yes", "", "", "yes"),
      Content("من فضلك إقرأ قائمة الطعام لي", "assets/menu.png", "yes", "", "",
          "yes")
    ]),
    lib("المستشفى", "assets/7ss.png", "yes", [
      Content("أريد أن احجز موعد قريبا ", "assets/appointment.png", "yes", "",
          "", "yes"),
      Content(
          "لدي الم شديد هنا ", "assets/muscle-pain.png", "yes", "", "", "yes"),
      Content("أريد الإسعاف عاجلا ",
          "assets/IconLib/transportation/ambulance.png", "yes", "", "", "yes"),
      Content("هل يوجد مستوصف قريب من هنا", "assets/clinic.png", "yes", "", "",
          "yes"),
      Content("أريد صرف الدواء من فضلك ", "assets/medicine.png", "yes", "", "",
          "yes"),
      Content("كم جرعة الدواء ومتى؟", "assets/clock.png", "yes", "", "", "yes"),
      Content("شكرا لك و أنا ممنون لك", "assets/positive-vote.png", "yes", "",
          "", "yes"),
      Content("اطلب الطبيب لي", "assets/doctor.png", "yes", "", "", "yes")
    ]),
    lib("المسجد", "assets/8ss.png", "yes", [
      Content("هل قامت الصلاة", "assets/shalat.png", "yes", "", "", "yes"),
      Content("أريد ان اتوضأ أين المواضئ ", "assets/wudhu.png", "yes", "", "",
          "yes"),
      Content("كم ركعة فاتتني ", "assets/islamic.png", "yes", "", "", "yes"),
      Content("أين اتجاه القبلة", "assets/kaaba.png", "yes", "", "", "yes"),
      Content("أين يقع اقرب مسجد", "assets/ramadan.png", "yes", "", "", "yes"),
      Content("هل يوجد مدخل خاص للكراسي المتحركة ؟ ", "assets/ramp.png", "yes",
          "", "", "yes")
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "اختر المكتبات لاستخدامها\n في التطبيق",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 42,
                              color: maincolor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("يمكنك التعديل لاحقاً",
                            style: TextStyle(fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 200,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/uiImages/chooseLibImage.png"),
                            fit: BoxFit.fill)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 15,left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  indexesChooese.isNotEmpty
                  ?Text(
                    "${indexesChooese.length}  من  ${chooseLibrary.length} ",
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ):Container(),

                          InkWell(
                            onTap: () {
                              if(selectAl==0){

                                indexesChooese = [];
                                for (int i = 0; i < chooseLibrary.length; i++) {
                                  setState(() {

                                    indexesChooese.add(i);
                                  });
                                }
                                setState(() {
                                  selectAl=1;
                                });


                              }else{
                                setState(() {
                                  indexesChooese = [];
                                  selectAl=0;
                                });
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(0.1),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                children:  [
                                  Icon(selectAl!=0?Icons.check_circle_outline:Icons.circle_outlined,
                                    size: DeviceUtil.isTablet
                                        ? 30
                                        : 20,),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    'تحديد الكل',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),


                ],
              ),
            ),

            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color:
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(27)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 3)),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              crossAxisCount:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 5
                                      : 7,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: chooseLibrary.length,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  if (indexesChooese.contains(index)) {
                                    setState(() {
                                      indexesChooese.remove(index);
                                    });
                                  } else {
                                    setState(() {
                                      indexesChooese.add(index);
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: greyColor),
                                      color: const Color.fromARGB(
                                              255, 255, 255, 255)
                                          .withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(27)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.7),
                                          spreadRadius: 0,
                                          blurRadius: 7,
                                          //offset: Offset(0, 3)),
                                        )
                                      ],
                                    ),
                                    child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Column(children: [
                                                Expanded(
                                                    child: Image.asset(
                                                        chooseLibrary[index]
                                                            .imgurl)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: FittedBox(
                                                    child: Text(
                                                      chooseLibrary[index].name,
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ])),
                                          indexesChooese.contains(index)
                                              ? Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    height: DeviceUtil.isTablet
                                                        ? 30
                                                        : 20,
                                                    width: DeviceUtil.isTablet
                                                        ? 30
                                                        : 20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          27),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.white
                                                              .withOpacity(0.5),
                                                          spreadRadius: 3,
                                                          blurRadius: 7,
                                                          //offset: Offset(0, 3)),
                                                        )
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      Icons.circle,
                                                      color: Colors.red,
                                                      size: DeviceUtil.isTablet
                                                          ? 25
                                                          : 18,
                                                    ),
                                                  ),
                                                )
                                              : Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                      height: DeviceUtil.isTablet
                                                          ? 30
                                                          : 20,
                                                      width: DeviceUtil.isTablet
                                                          ? 30
                                                          : 20,
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              224, 223, 223),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          border: Border.all(
                                                              color: Colors.red,
                                                              width: 3))),
                                                )
                                        ]),
                                  ),
                                ),
                              );
                            })))
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               /* Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/uiImages/countImages.png"),
                              fit: BoxFit.fill)),
                    ),
                    //  SizedBox(width: 100,height: 50,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 10),
                      child: Text(
                        "${indexesChooese.length} - ${chooseLibrary.length} ",
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),*/
             /*   SizedBox(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 40
                        : 130),*/
                InkWell(
                  onTap: () async {
                    if (indexesChooese.isNotEmpty) {
                      SharedPreferences liblistChild =
                          await SharedPreferences.getInstance();
                      List<String> libstring = [];
                      for (var index in indexesChooese) {
                        libstring.add(convertLibString(chooseLibrary[index]));
                      }
                      liblistChild.setStringList("liblistChild", libstring);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainChildPage(
                                    index: 0,
                                  )));
                    } else {
                      erroralert(context, "يرجى اختيار مكتبة واحدة على الاقل");
                    }
                  },
                  child: Image.asset(
                    "assets/uiImages/start.png",
                    height: 85,
                  ),
                ),
                Container(
                  height: 18,
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences liblistChild =
                    await SharedPreferences.getInstance();
                    List<String> libstring = [];
                    int j =chooseLibrary.length;
                    for (var i=0;i< j;i++) {
                      print(i);
                      libstring.add(convertLibString(chooseLibrary[i]));
                    }
                    liblistChild.setStringList("liblistChild", libstring);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainChildPage(
                              index: 0,
                            )));
                  },
                  child: Text(
                    "تخطي هذا",
                    style: TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Container(
                  height: 18,
                ),
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
      )),
    );
  }
}
