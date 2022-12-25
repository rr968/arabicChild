import '/controller/libtostring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/content.dart';
import '../model/library.dart';

Future setDataChildOneTime() async {
  SharedPreferences firsttime = await SharedPreferences.getInstance();
  bool? first = firsttime.getBool("firsttimeChild");
  if (first == null || first == true) {
    List<String> libr = [
      convertLibString(lib("التحيات", "assets/1ss.png", "yes", [
        Content("كيف حالك؟ ", "assets/question.png", "yes", "", "", "yes"),
        Content("اهلا وسهلا ", "assets/waving-hand.png", "yes", "", "", "yes"),
        Content("مرحبا حياك الله ", "assets/introduction.png", "yes", "", "",
            "yes"),
        Content(
            "أنا بخير والحمدلله ", "assets/prayer.png", "yes", "", "", "yes"),
        Content("وعليكم السلام ", "assets/hello.png", "yes", "", "", "yes"),
        Content("سعدت بالحديث معك مع السلامة ", "assets/hello (1).png", "yes",
            "", "", "yes")
      ])),
      convertLibString(lib("العمل", "assets/2ss.png", "yes", [
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
      ])),
      convertLibString(lib("السوق", "assets/3ss.png", "yes", [
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
      ])),
      convertLibString(lib("السفر", "assets/4ss.png", "yes", [
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
      ])),
      convertLibString(lib("المدرسة", "assets/5ss.png", "yes", [
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
      ])),
      convertLibString(lib("المطعم", "assets/6ss.png", "yes", [
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
      ])),
      convertLibString(lib("المستشفى", "assets/7ss.png", "yes", [
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
      ])),
      convertLibString(lib("المسجد", "assets/8ss.png", "yes", [
        Content("هل قامت الصلاة", "assets/shalat.png", "yes", "", "", "yes"),
        Content("أريد ان اتوضأ أين المواضئ ", "assets/wudhu.png", "yes", "", "",
            "yes"),
        Content("كم ركعة فاتتني ", "assets/islamic.png", "yes", "", "", "yes"),
        Content("أين اتجاه القبلة", "assets/kaaba.png", "yes", "", "", "yes"),
        Content(
            "أين يقع اقرب مسجد", "assets/ramadan.png", "yes", "", "", "yes"),
        Content("هل يوجد مدخل خاص للكراسي المتحركة ؟ ", "assets/ramp.png",
            "yes", "", "", "yes")
      ])),
    ];
    SharedPreferences liblist = await SharedPreferences.getInstance();
    liblist.setStringList("liblistChild", libr);
    firsttime.setBool("firsttimeChild", true);
  }
}
