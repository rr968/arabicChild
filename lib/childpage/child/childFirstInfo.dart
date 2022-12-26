// ignore_for_file: prefer_const_constructors

import 'dart:convert';


import '../../controller/data_one_time.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';

import '../../controller/images.dart';
import '../../controller/libtostring.dart';
import '../../model/content.dart';
import '../../model/library.dart';

import '../../controller/var.dart';
import 'mainchildPage.dart';

double numofelements = 3;

class ChildInfo extends StatefulWidget {
  ChildInfo({Key? key}) : super(key: key);

  @override
  // ignore: override_on_non_overriding_member
  final List Questions = [NumofItems(), Selectedlib()];
  State<ChildInfo> createState() => _ChildInfoState();
}

class _ChildInfoState extends State<ChildInfo> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ConcentricPageView(
      onChange: (e) {
        if (e >= 1) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Selectedlib()),
                  (route) => false);
        }
      },
      reverse: true,
      colors: [maincolor,maincolor],
      itemBuilder: (int index) {
        return SafeArea(child: widget.Questions[index]);
        //return Speaking();
      },
      radius: screenWidth * 0.1,
      nextButtonBuilder: (context) => Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          size: screenWidth * 0.1,
        ),
      ),
    );
  }
}

class NumofItems extends StatefulWidget {
  const NumofItems({Key? key}) : super(key: key);

  @override
  State<NumofItems> createState() => _NumofItemsState();
}

class _NumofItemsState extends State<NumofItems> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("معلومات اساسية",
              style: const TextStyle(
                  color: Colors.white, fontSize: 20)
          ),
          backgroundColor: maincolor,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "عدد العناصر في الصف : ",
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
              ),

            ]),
      ),
    );
  }


}

class Selectedlib extends StatefulWidget {
  const Selectedlib({Key? key}) : super(key: key);

  @override
  State<Selectedlib> createState() => _SelectedlibState();
}

class _SelectedlibState extends State<Selectedlib> {
  List<int>indexesChooese=[];
  List<lib> chooseLibrary=[
    lib("التحيات", "assets/1ss.png", "yes", [
      Content("كيف حالك؟ ", "assets/question.png", "yes", "", "", "yes"),
      Content("اهلا وسهلا ", "assets/waving-hand.png", "yes", "", "", "yes"),
      Content("مرحبا حياك الله ", "assets/introduction.png", "yes", "", "",
          "yes"),
      Content(
          "أنا بخير والحمدلله ", "assets/prayer.png", "yes", "", "", "yes"),
      Content("وعليكم السلام ", "assets/hello.png", "yes", "", "", "yes"),
      Content("سعدت بالحديث معك مع السلامة ", "assets/hello (1).png", "yes",
          "", "", "yes")
    ]),
    lib("العمل", "assets/2ss.png", "yes", [
      Content(
          "أين مكتب العمل؟ ", "assets/location.png", "yes", "", "", "yes"),
      Content(
          "أريد السكرتير ", "assets/secretary (1).png", "yes", "", "", "yes"),
      Content("أنا ابحث عن عمل يناسبني ", "assets/wheelchair (1).png", "yes",
          "", "", "yes"),
      Content(
          "هل انتهى الدوام ؟ ", "assets/expired.png", "yes", "", "", "yes"),
      Content("ماهي البيانات المطلوبة", "assets/requirement.png", "yes", "",
          "", "yes"),
      Content(
          "كيف أخدمك ؟ ", "assets/manufacturing.png", "yes", "", "", "yes")
    ]),lib("السوق", "assets/3ss.png", "yes", [
      Content("كم سعر هذا؟", "assets/how-much.png", "yes", "", "", "yes"),
      Content("السعر مرتفع جدًا", "assets/money.png", "yes", "", "", "yes"),
      Content("هل لديكم فرع آخر؟", "assets/branch.png", "yes", "", "", "yes"),
      Content(
          "أريد خضراوات طازجة", "assets/vegetable.png", "yes", "", "", "yes"),
      Content("هل لديكم تخفيضات؟", "assets/tag.png", "yes", "", "", "yes"),
      Content("أين أجد قسم الملابس؟", "assets/clothing.png", "yes", "", "",
          "yes"),
      Content("أريد أن تساعدني في الحصول على القطع في الرف المرتفع",
          "assets/stand.png", "yes", "", "", "yes"),
      Content("لقد سقط هذا مني أرجوك أحضره", "assets/bring-to-front.png",
          "yes", "", "", "yes"),
      Content("أريد أن أدفع المبلغ تفضل", "assets/money (1).png", "yes", "",
          "", "yes"),
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
      Content("هذه أمتعتي أريدك أن تساعدني", "assets/travel-bag.png", "yes",
          "", "", "yes"),
      Content("شكرًا لك وأنا ممنون لك", "assets/IconLib/body/hands.png",
          "yes", "", "", "yes")
    ]),
    lib("المدرسة", "assets/5ss.png", "yes", [
      Content("أستاذ أنا لم أفهم هذه المسألة", "assets/hypothesis.png", "yes",
          "", "", "yes"),
      Content("أريد أن أحل هذه المسألة", "assets/problem (1).png", "yes", "",
          "", "yes"),
      Content("لقد انتهيت", "assets/tick.png", "yes", "", "", "yes"),
      Content("أريد الخروج من الفصل", "assets/exit-door.png", "yes", "", "",
          "yes"),
      Content(
          "كم درجة الاختبار؟", "assets/homework.png", "yes", "", "", "yes"),
      Content("متى ينتهي الدوام؟", "assets/working-time.png", "yes", "", "",
          "yes"),
      Content("أريد أن تساعدني في كتابة عبارات جديدة لاستخدامها في المدرسة",
          "assets/skill.png", "yes", "", "", "yes"),
      Content("إلى اللقاء، مع السلامة", "assets/goodbye.png", "yes", "", "",
          "yes"),
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
      Content("هل لديكم توصيل للمنازل؟", "assets/home-delivery.png", "yes",
          "", "", "yes"),
      Content("أنا أستخدم برنامج على الهاتف للتواصل معك، فأرجو أن تتساعد معي",
          "assets/smartphone.png", "yes", "", "", "yes"),
      Content("الطعم لذيذ شكرًا", "assets/tasty.png", "yes", "", "", "yes"),
      Content("هل لديكم شبكة للدفع؟", "assets/mobile-payment.png", "yes", "",
          "", "yes"),
      Content("كم مجموع الطعام؟", "assets/hand.png", "yes", "", "", "yes"),
      Content("أريد الباقي لوسمحت", "assets/payment-method.png", "yes", "",
          "", "yes"),
      Content("أبحث عن مطعم شعبي قريب من هنا", "assets/restaurant (1).png",
          "yes", "", "", "yes"),
      Content("من فضلك إقرأ قائمة الطعام لي", "assets/menu.png", "yes", "",
          "", "yes")
    ]),
    lib("المستشفى", "assets/7ss.png", "yes", [
      Content("أريد أن احجز موعد قريبا ", "assets/appointment.png", "yes", "",
          "", "yes"),
      Content("لدي الم شديد هنا ", "assets/muscle-pain.png", "yes", "", "",
          "yes"),
      Content(
          "أريد الإسعاف عاجلا ",
          "assets/IconLib/transportation/ambulance.png",
          "yes",
          "",
          "",
          "yes"),
      Content("هل يوجد مستوصف قريب من هنا", "assets/clinic.png", "yes", "",
          "", "yes"),
      Content("أريد صرف الدواء من فضلك ", "assets/medicine.png", "yes", "",
          "", "yes"),
      Content(
          "كم جرعة الدواء ومتى؟", "assets/clock.png", "yes", "", "", "yes"),
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
      Content(
          "أين يقع اقرب مسجد", "assets/ramadan.png", "yes", "", "", "yes"),
      Content("هل يوجد مدخل خاص للكراسي المتحركة ؟ ", "assets/ramp.png",
          "yes", "", "", "yes")
    ]),
  ];






  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: indexesChooese.length>0
              ? InkWell(
            child: Icon(Icons.clear),
            onTap: () {
              setState(() {
                indexesChooese=[];
              });
            },
          )
              : Container(),
          title: indexesChooese.length>0
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    "${indexesChooese.length} ",
                    style: const TextStyle(
                        color: Colors.white, fontSize: 20),
                  ),
                  const Text(
                    " من المكتبات",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  indexesChooese=[];
                  for(int i=0;i< chooseLibrary.length;i++){
                    setState(() {
                      indexesChooese.add(i);
                    });
                  }
                },
                child: Column(
                  children: const [
                    Icon(
                      Icons.checklist,
                      color: Colors.white,
                    ),
                    Text(
                      "تحديد الكل",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " المكتبات",
                style: TextStyle(
                    fontSize: 24,
                    //  fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          backgroundColor: maincolor,
        ),
        body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SafeArea(
                  child:  SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child:GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  mainAxisSpacing: 10,
                          crossAxisSpacing: 10,crossAxisCount: 4),
                          itemCount:chooseLibrary.length,
                          itemBuilder:( (context,index){
                            return Stack(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: maincolor, width: 1.5),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Column(children: [
                                        Expanded(
                                            child:Image.asset(chooseLibrary[index].imgurl)),
                                        const SizedBox(
                                          height: 7,
                                        ), Padding(
                                          padding: const EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            chooseLibrary[index].name,
                                            style: TextStyle(
                                                fontSize: size == 0 ? 30 : 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )])),
                                  indexesChooese.contains(index)?
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      height: 23,
                                      width: 23,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 224, 223, 223),
                                          borderRadius:
                                          BorderRadius.circular(40),
                                          border: Border.all(
                                              color: Colors.red, width: 3)),
                                      child: const Icon(
                                        Icons.done,
                                        color: Colors.red,
                                        size: 17,
                                      ),
                                    ),
                                  ):Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: InkWell(
                                      onTap:(){
                                        setState(() {
                                          indexesChooese.add(index);

                                        });

                            },
                                      child: Container(
                                          height: 23,
                                          width: 23,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 224, 223, 223),
                                              borderRadius:
                                              BorderRadius.circular(40),
                                              border: Border.all(
                                                  color: Colors.red, width: 3))
                                      ),
                                    ),



                                  )]);})

                      )

                  ),



                ),

              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text(
                          "تم",
                          style: TextStyle(fontSize: 30,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: maincolor,

                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: Size(100, 40), //////// HERE
                        ),
                        onPressed: () async {
                          SharedPreferences liblistChild = await SharedPreferences.getInstance();
                          List<String>libstring=[];
                          indexesChooese.forEach((index) {
                            libstring.add(convertLibString(chooseLibrary[index]));
                          });
                          liblistChild.setStringList("liblistChild",libstring);

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => MainChildPage(
                                index: 0,
                              )));
                        }
                    ),


                  ]),

            ]),
      ),
    );
  }
}

