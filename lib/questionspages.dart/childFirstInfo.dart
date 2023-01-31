// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../controller/istablet.dart';
import '../controller/libtostring.dart';
import '../model/content.dart';
import '../model/library.dart';

import '../controller/var.dart';
import '../childpage/child/mainchildPage.dart';

class Selectedlib extends StatefulWidget {
  const Selectedlib({Key? key}) : super(key: key);

  @override
  State<Selectedlib> createState() => _SelectedlibState();
}

class _SelectedlibState extends State<Selectedlib> {
  List<int> indexesChooese = [];
  int selectAl = 0;
  List<lib> chooseLibrary = [
    lib("المستشفى", "assets/7ss.png", "yes", [
      Content("عندي ألم في بطني", "assets/images/stomach-ache.png", "yes", "",
          "", "yes"),
      Content("عندي ألم في رجلي", "assets/images/legPain.png", "yes", "", "",
          "yes"),
      Content(
          "عندي ألم في يدي", "assets/images/injury.png", "yes", "", "", "yes"),
      Content("عندي ألم في رأسي", "assets/images/headache.png", "yes", "", "",
          "yes"),
      Content("إرفع يدي", "assets/images/raiseHand.png", "yes", "", "", "yes"),
      Content("إرفع رجلي", "assets/images/fitness.png", "yes", "", "", "yes"),
      Content(
          "حرك الوسادة فوق", "assets/images/move5.png", "yes", "", "", "yes"),
      Content(
          "حرك الوسادة تحت", "assets/images/move-2.png", "yes", "", "", "yes"),
      Content(
          "حرك الوسادة يمين", "assets/images/move-3.png", "yes", "", "", "yes"),
      Content(
          "حرك الوسادة يسار", "assets/images/move-4.png", "yes", "", "", "yes"),
      Content("إقلبني على جنب الأيمن", "assets/images/driving.png", "yes", "",
          "", "yes"),
      Content("إقلبني على جنب الأيسر", "assets/images/driving-2.png", "yes", "",
          "", "yes"),
      Content("اغلق الباب", "assets/images/door.png", "yes", "", "", "yes"),
      Content("اغلق النور", "assets/images/bulb.png", "yes", "", "", "yes"),
      Content("احتاج مساعدة", "assets/images/help.png", "yes", "", "", "yes"),
      Content("احتاج شفط", "assets/images/suction.png", "yes", "", "", "yes"),
      Content(
          "أريد الاتصال", "assets/images/phonecall.png", "yes", "", "", "yes"),
      /* Content("أريد أن احجز موعد قريبا ", "assets/appointment.png", "yes", "", "",
        "yes"),
    Content(
        "لدي الم شديد هنا ", "assets/muscle-pain.png", "yes", "", "", "yes"),
    Content("أريد الإسعاف عاجلا ",
        "assets/IconLib/transportation/ambulance.png", "yes", "", "", "yes"),
    Content("هل يوجد مستوصف قريب من هنا", "assets/clinic.png", "yes", "", "",
        "yes"),
    Content("أريد صرف الدواء من فضلك ", "assets/medicine.png", "yes", "", "",
        "yes"),
    Content("كم جرعة الدواء ومتى؟", "assets/clock.png", "yes", "", "", "yes"),
    Content("شكرا لك و أنا ممنون لك", "assets/positive-vote.png", "yes", "", "",
        "yes"),
    Content("اطلب الطبيب لي", "assets/doctor.png", "yes", "", "", "yes")*/
    ]),
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
      Content("حاسبة ", "assets/IconLib/School/calculator.png", "yes", "", "",
          "yes"),
      Content("حقيبة ظهر ", "assets/IconLib/School/backpack.png", "yes", "", "",
          "yes"),
      Content("زائد ", "assets/IconLib/School/add.png", "yes", "", "", "yes"),
      Content(
          "ناقص ", "assets/IconLib/School/remove.png", "yes", "", "", "yes"),
      Content("نصف ", "assets/IconLib/School/half.png", "yes", "", "", "yes"),
      Content(
          "يساوي ", "assets/IconLib/School/equal.png", "yes", "", "", "yes"),
      Content(
          "قسمة ", "assets/IconLib/School/divide.png", "yes", "", "", "yes"),
      Content(
          "رقم ", "assets/IconLib/School/numbers.png", "yes", "", "", "yes"),
      Content(
          "فواصل ", "assets/IconLib/School/comma.png", "yes", "", "", "yes"),
      Content(
          "رتب ", "assets/IconLib/School/arrange.png", "yes", "", "", "yes"),
      Content("دبوس", "assets/IconLib/School/18.png", "yes", "", "", "yes"),
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
    lib("الملابس", "assets/IconLib/clothes/0.png", "yes", [
      Content("تغيير الملابس", "assets/IconLib/clothes/change.png", "yes", "",
          "", "yes"),
      Content("فتح الزر  ", "assets/IconLib/clothes/button.png", "yes", "", "",
          "yes"),
      Content("اغلاق الزر", "assets/IconLib/clothes/button (1).png", "yes", "",
          "", "yes"),
      Content(
          "كبير جدا", "assets/IconLib/clothes/loose.png", "yes", "", "", "yes"),
      Content("ضيق جدا", "assets/IconLib/clothes/TightJeans.png", "yes", "", "",
          "yes"),
      Content("متسخ", "assets/IconLib/clothes/dirty.png", "yes", "", "", "yes"),
      Content("ارتداء الملابس", "assets/IconLib/clothes/getDressed.png", "yes",
          "", "", "yes"),
      Content("اغلاق السحاب", "assets/IconLib/clothes/zipper.png", "yes", "",
          "", "yes"),
      Content("فتح السحاب", "assets/IconLib/clothes/unzip.png", "yes", "", "",
          "yes"),
      Content("بنطال مبلل  ", "assets/IconLib/clothes/wetpants.png", "yes", "",
          "", "yes"),
      Content("ملابس داخلية", "assets/IconLib/clothes/underwear.png", "yes", "",
          "", "yes"),
      Content("شراب", "assets/IconLib/clothes/socks.png", "yes", "", "", "yes"),
      Content("حذاء رياضي", "assets/IconLib/clothes/sneakers.png", "yes", "",
          "", "yes"),
      Content("ملابس  ", "assets/IconLib/clothes/0.png", "yes", "", "", "yes"),
      Content(
          "محفظة", "assets/IconLib/clothes/wallet.png", "yes", "", "", "yes"),
      Content("ساعة", "assets/IconLib/clothes/watch.png", "yes", "", "", "yes"),
      Content("أقراط أذن ", "assets/IconLib/clothes/earings.png", "yes", "", "",
          "yes"),
      Content(
          "تنورة ", "assets/IconLib/clothes/skirt-m.png", "yes", "", "", "yes"),
      Content(
          " عباية ", "assets/IconLib/clothes/abaya.png", "yes", "", "", "yes"),
      Content(
          " شورت ", "assets/IconLib/clothes/shorts.png", "yes", "", "", "yes"),
      Content(
          " حذاء ", "assets/IconLib/clothes/shoes-m.png", "yes", "", "", "yes"),
      Content(" كوت ", "assets/IconLib/clothes/Coat.png", "yes", "", "", "yes"),
      Content(" كاب ", "assets/IconLib/clothes/cap.png", "yes", "", "", "yes"),
      Content(
          " قميص ", "assets/IconLib/clothes/Shirt.png", "yes", "", "", "yes"),
      Content(
          "حقيبة  ", "assets/IconLib/clothes/3-m.png", "yes", "", "", "yes"),
      Content(" اكسسوارات ", "assets/IconLib/clothes/1-m.png", "yes", "", "",
          "yes"),
      Content("ملابس ملونه ", "assets/IconLib/clothes/clothes-m.png", "yes", "",
          "", "yes"),
    ]),
    lib("الأماكن", "assets/IconLib/Places/place.png", "yes", [
      Content("مدرسة ", "assets/IconLib/Places/school-bus.png", "yes", "", "",
          "yes"),
      Content("منزل ", "assets/IconLib/Places/home.png", "yes", "", "", "yes"),
      Content(
          "مستشفى", "assets/IconLib/Places/hospital.png", "yes", "", "", "yes"),
      Content("مكتبة ", "assets/IconLib/Places/library (1).png", "yes", "", "",
          "yes"),
      Content("مركز تجاري", "assets/IconLib/Places/shopping-center.png", "yes",
          "", "", "yes"),
      Content("محل قهوة ", "assets/IconLib/Places/coffeeshop.png", "yes", "",
          "", "yes"),
      Content("مطعم ", "assets/IconLib/Places/restaurant.png", "yes", "", "",
          "yes"),
      Content(
          "مسجد ", "assets/IconLib/Places/mosque.png", "yes", "", "", "yes"),
      Content("دورة مياه - رجال", "assets/IconLib/Places/Toilet-man.png", "yes",
          "", "", "yes"),
      Content("دورة مياه - نساء ", "assets/IconLib/Places/Toilet-w.png", "yes",
          "", "", "yes"),
      Content("سوبر ماركت  ", "assets/IconLib/Places/Supermarket.png", "yes",
          "", "", "yes"),
      Content("مكة ", "assets/IconLib/Places/mecca.jpg", "yes", "", "", "yes"),
      Content("منى ", "assets/IconLib/Places/mina.png", "yes", "", "", "yes"),
      Content("مزدلفة ", "assets/IconLib/Places/Muzdalifah.png", "yes", "", "",
          "yes"),
    ]),
    lib("العائلة", "assets/IconLib/family/0.jpg", "yes", [
      Content("طفل", "assets/IconLib/family/1.png", "yes", "", "", "yes"),
      Content("ولد", "assets/IconLib/family/2.png", "yes", "", "", "yes"),
      Content("اولادي", "assets/IconLib/family/myChildren.png", "yes", "", "",
          "yes"),
      Content("شيخ", "assets/IconLib/family/6.jpg", "yes", "", "", "yes"),
      Content("ام ", "assets/IconLib/family/mother.png", "yes", "", "", "yes"),
      Content("اخ", "assets/IconLib/family/brother.png", "yes", "", "", "yes"),
      Content("اب ", "assets/IconLib/family/father.png", "yes", "", "", "yes"),
      Content(
          "اطفال", "assets/IconLib/family/childern.png", "yes", "", "", "yes"),
      Content("عائلة", "assets/IconLib/family/8.jpg", "yes", "", "", "yes"),
      Content("بنت", "assets/IconLib/family/9.png", "yes", "", "", "yes"),
      Content("جد", "assets/IconLib/family/10.png", "yes", "", "", "yes"),
      Content("جدة", "assets/IconLib/family/11.png", "yes", "", "", "yes"),
      Content("انا", "assets/IconLib/family/12.png", "yes", "", "", "yes"),
      Content("اخت ", "assets/IconLib/family/Sister.png", "yes", "", "", "yes"),
    ]),
    lib("الوان", "assets/IconLib/colors-m/0.png", "yes", [
      Content("اسود", "assets/IconLib/colors-m/1.png", "yes", "", "", "yes"),
      Content("ازرق", "assets/IconLib/colors-m/2.png", "yes", "", "", "yes"),
      Content("اخضر", "assets/IconLib/colors-m/3.png", "yes", "", "", "yes"),
      Content("بنفسجي", "assets/IconLib/colors-m/4.png", "yes", "", "", "yes"),
      Content("احمر", "assets/IconLib/colors-m/5.png", "yes", "", "", "yes"),
      Content("ابيض", "assets/IconLib/colors-m/6.png", "yes", "", "", "yes"),
      Content("اصفر", "assets/IconLib/colors-m/7.png", "yes", "", "", "yes"),
    ]),
    lib("الجسم", "assets/IconLib/body/0.png", "yes", [
      Content("كعب", "assets/IconLib/body/1.png", "yes", "", "", "yes"),
      Content("لسان", "assets/IconLib/body/2.png", "yes", "", "", "yes"),
      Content("ذراع", "assets/IconLib/body/3.png", "yes", "", "", "yes"),
      Content("عين", "assets/IconLib/body/4.png", "yes", "", "", "yes"),
      Content("أصابع القدم", "assets/IconLib/body/5.png", "yes", "", "", "yes"),
      Content("اسنان", "assets/IconLib/body/6.png", "yes", "", "", "yes"),
      Content("كتف", "assets/IconLib/body/7.png", "yes", "", "", "yes"),
      Content("رقبة", "assets/IconLib/body/8.png", "yes", "", "", "yes"),
      Content("يد ", "assets/IconLib/body/hands.png", "yes", "", "", "yes"),
      Content("اذن ", "assets/IconLib/body/ear.png", "yes", "", "", "yes"),
      Content("قدم", "assets/IconLib/body/foot.png", "yes", "", "", "yes"),
      Content("شعر", "assets/IconLib/body/hair.png", "yes", "", "", "yes"),
      Content("لسان ", "assets/IconLib/body/tongue.png", "yes", "", "", "yes"),
    ]),
    lib("المنزل", "assets/IconLib/Home/0.jpg", "yes", [
      Content("سرير أطفال", "assets/IconLib/Home/babyBed.png", "yes", "", "",
          "yes"),
      Content("سرير", "assets/IconLib/Home/Bed.png", "yes", "", "", "yes"),
      Content(
          "غرفة نوم", "assets/IconLib/Home/bedroom.png", "yes", "", "", "yes"),
      Content("سلة مهملات", "assets/IconLib/Home/wastebasket.png", "yes", "",
          "", "yes"),
      Content("كرسي", "assets/IconLib/Home/chair.png", "yes", "", "", "yes"),
      Content(" ادراج", "assets/IconLib/Home/8.png", "yes", "", "", "yes"),
      Content("حمام", "assets/IconLib/Home/public-toilet.png", "yes", "", "",
          "yes"),
      Content(
          "المطبخ ", "assets/IconLib/Home/kitchen.png", "yes", "", "", "yes"),
      Content(
          "منديل يد ", "assets/IconLib/Home/tissue.png", "yes", "", "", "yes"),
      Content("أريكة", "assets/IconLib/Home/sofa.png", "yes", "", "", "yes"),
      Content("اجهزة تجكم ", "assets/IconLib/Home/0.jpg", "yes", "", "", "yes"),
      Content("غطاء", "assets/IconLib/Home/bedCover.png", "yes", "", "", "yes"),
      Content("خزانة", "assets/IconLib/Home/12.png", "yes", "", "", "yes"),
      Content("مفتاح", "assets/IconLib/Home/key.jpg", "yes", "", "", "yes"),
      Content("ممسحة", "assets/IconLib/Home/wiper.png", "yes", "", "", "yes"),
      Content("مشبك", "assets/IconLib/Home/buckle.png", "yes", "", "", "yes"),
      Content("مقعد", "assets/IconLib/Home/seat.png", "yes", "", "", "yes"),
      Content(" شباك", "assets/IconLib/Home/windows.png", "yes", "", "", "yes"),
      Content("الطابق العلوي", "assets/IconLib/Home/upstairs.png", "yes", "",
          "", "yes"),
      Content("الطابق السفلي", "assets/IconLib/Home/downstairs.png", "yes", "",
          "", "yes"),
      Content(
          "الباب", "assets/IconLib/Home/door-closed.png", "yes", "", "", "yes"),
      Content("العاب كروت", "assets/IconLib/Home/card-game.png", "yes", "", "",
          "yes"),
    ]),
    lib("الحيوانات", "assets/IconLib/Animall/0.png", "yes", [
      Content("حمار", "assets/IconLib/Animall/18.jpg", "yes", "", "", "yes"),
      Content("ذئب", "assets/IconLib/Animall/17.jpg", "yes", "", "", "yes"),
      Content("ثعبان", "assets/IconLib/Animall/13.png", "yes", "", "", "yes"),
      Content("نمر ", "assets/IconLib/Animall/16.png", "yes", "", "", "yes"),
      Content("طاووس", "assets/IconLib/Animall/15.jpg", "yes", "", "", "yes"),
      Content("راما", "assets/IconLib/Animall/12.png", "yes", "", "", "yes"),
      Content("سلحفاة", "assets/IconLib/Animall/14.png", "yes", "", "", "yes"),
      Content("فيل", "assets/IconLib/Animall/21.jpg", "yes", "", "", "yes"),
      Content("خفاش", "assets/IconLib/Animall/20.png", "yes", "", "", "yes"),
      Content("بطة", "assets/IconLib/Animall/19.png", "yes", "", "", "yes"),
      Content("دب", "assets/IconLib/Animall/1.jpg", "yes", "", "", "yes"),
      Content("عصفور", "assets/IconLib/Animall/2.png", "yes", "", "", "yes"),
      Content("قطة", "assets/IconLib/Animall/3.png", "yes", "", "", "yes"),
      Content("دجاج", "assets/IconLib/Animall/4.png", "yes", "", "", "yes"),
      Content("بقرة", "assets/IconLib/Animall/5.jpg", "yes", "", "", "yes"),
      Content("غراب", "assets/IconLib/Animall/6.jpg", "yes", "", "", "yes"),
      Content("غزال", "assets/IconLib/Animall/7.png", "yes", "", "", "yes"),
      Content("ديناصور", "assets/IconLib/Animall/8.jpg", "yes", "", "", "yes"),
      Content("ماعز", "assets/IconLib/Animall/9.png", "yes", "", "", "yes"),
      Content("كلب", "assets/IconLib/Animall/10.png", "yes", "", "", "yes"),
      Content("ارنب", "assets/IconLib/Animall/11.png", "yes", "", "", "yes"),
    ]),
    lib("الطعام", "assets/IconLib/food/veg.png", "yes", [
      Content("خضروات", "assets/IconLib/food/veg.png", "yes", "", "", "yes"),
      Content("طماطم", "assets/IconLib/food/tomato.png", "yes", "", "", "yes"),
      Content(
          "فراولة", "assets/IconLib/food/strawbrry.png", "yes", "", "", "yes"),
      Content("قرع", "assets/IconLib/food/pumpkin.png", "yes", "", "", "yes"),
      Content("بطاطس مقلي", "assets/IconLib/food/potatoes.jpg", "yes", "", "",
          "yes"),
      Content("بيتزا", "assets/IconLib/food/pizza.png", "yes", "", "", "yes"),
      Content("كمثرى", "assets/IconLib/food/pear.png", "yes", "", "", "yes"),
      Content("فطر", "assets/IconLib/food/mushroom.jpg", "yes", "", "", "yes"),
      Content("نعناع", "assets/IconLib/food/mint.png", "yes", "", "", "yes"),
      Content("غداء", "assets/IconLib/food/lunch.jpg", "yes", "", "", "yes"),
      Content("ملفوف", "assets/IconLib/food/lettuce.jpg", "yes", "", "", "yes"),
      Content("مانجو", "assets/IconLib/food/mango.jpg", "yes", "", "", "yes"),
      Content("عنب", "assets/IconLib/food/grape.png", "yes", "", "", "yes"),
      Content("فواكهه", "assets/IconLib/food/fruits.png", "yes", "", "", "yes"),
      Content(
          "فلفل", "assets/IconLib/food/hot-pepper.png", "yes", "", "", "yes"),
      Content(
          "آيسكريم", "assets/IconLib/food/icecream.jpg", "yes", "", "", "yes"),
      Content("كيوي", "assets/IconLib/food/ki.png", "yes", "", "", "yes"),
    ]),
    lib("فعل", "assets/IconLib/actions/family.png", "yes", [
      Content("فكرة", "assets/IconLib/actions/idea.png", "yes", "", "", "yes"),
      Content("ضحك", "assets/IconLib/actions/laugh.jpg", "yes", "", "", "yes"),
      Content(
          "تذكر", "assets/IconLib/actions/remember.png", "yes", "", "", "yes"),
      Content("غضب", "assets/IconLib/actions/angry.jpg", "yes", "", "", "yes"),
      Content("يحلم", "assets/IconLib/actions/dream.png", "yes", "", "", "yes"),
      Content("عض", "assets/IconLib/actions/bite.png", "yes", "", "", "yes"),
      Content("سعال", "assets/IconLib/actions/cough.png", "yes", "", "", "yes"),
      Content(
          "يتحدث", "assets/IconLib/actions/speak.png", "yes", "", "", "yes"),
      Content("ينظر", "assets/IconLib/actions/look.png", "yes", "", "", "yes"),
      Content("اخذ صورة", "assets/IconLib/actions/TakeImage.png", "yes", "", "",
          "yes"),
      Content(
          "تنظر", "assets/IconLib/actions/sheLook.png", "yes", "", "", "yes"),
      Content("الم", "assets/IconLib/actions/pain.png", "yes", "", "", "yes"),
      Content(
          "مستيقظ ", "assets/IconLib/actions/awake.png", "yes", "", "", "yes"),
    ]),
    lib("وسائل نقل", "assets/IconLib/transportation/0.png", "yes", [
      Content(
          "قارب", "assets/IconLib/transportation/1.png", "yes", "", "", "yes"),
      Content(
          "باص", "assets/IconLib/transportation/2.png", "yes", "", "", "yes"),
      Content("سيارة اجرة", "assets/IconLib/transportation/3.png", "yes", "",
          "", "yes"),
      Content(
          "سيارة", "assets/IconLib/transportation/4.png", "yes", "", "", "yes"),
      Content("دراجة نارية", "assets/IconLib/transportation/5.png", "yes", "",
          "", "yes"),
      Content("سيارة الشرطة", "assets/IconLib/transportation/6.png", "yes", "",
          "", "yes"),
      Content("سيارة اسعاف", "assets/IconLib/transportation/ambulance.png",
          "yes", "", "", "yes"),
      Content(
          "طوافة", "assets/IconLib/transportation/7.png", "yes", "", "", "yes"),
      Content(
          "طريق", "assets/IconLib/transportation/8.png", "yes", "", "", "yes"),
      Content(
          "سفينة", "assets/IconLib/transportation/9.png", "yes", "", "", "yes"),
      Content("سيارة رياضية", "assets/IconLib/transportation/10.png", "yes", "",
          "", "yes"),
      Content(
          "شارع", "assets/IconLib/transportation/11.png", "yes", "", "", "yes"),
      Content(
          "قطار", "assets/IconLib/transportation/12.png", "yes", "", "", "yes"),
      Content("سيكل", "assets/IconLib/transportation/bicycle.png", "yes", "",
          "", "yes"),
      Content("سكوتر", "assets/IconLib/transportation/Scooter.png", "yes", "",
          "", "yes"),
      Content("سيارة اطفاء", "assets/IconLib/transportation/fire-truck.png",
          "yes", "", "", "yes"),
    ]),
    lib("مهن", "assets/IconLib/careers/0.png", "yes", [
      Content("خباز", "assets/IconLib/careers/1.jpg", "yes", "", "", "yes"),
      Content("حلاق", "assets/IconLib/careers/2.jpg", "yes", "", "", "yes"),
      Content("مهنة ", "assets/IconLib/careers/3.png", "yes", "", "", "yes"),
      Content("شرطي", "assets/IconLib/careers/4.png", "yes", "", "", "yes"),
      Content("مديرة", "assets/IconLib/careers/5.png", "yes", "", "", "yes"),
      Content(
          "دكتورة", "assets/IconLib/careers/doctor.png", "yes", "", "", "yes"),
      Content("سائق", "assets/IconLib/careers/7.png", "yes", "", "", "yes"),
      Content("صباغ", "assets/IconLib/careers/8.jpg", "yes", "", "", "yes"),
      Content(
          "دكتور", "assets/IconLib/careers/doctors.png", "yes", "", "", "yes"),
      Content("سباح", "assets/IconLib/careers/9.png", "yes", "", "", "yes"),
      Content("معلم/ة", "assets/IconLib/careers/10.png", "yes", "", "", "yes"),
    ]),
    lib("عبادات", "assets/IconLib/worship/0.png", "yes", [
      Content("عرفة", "assets/IconLib/worship/1.png", "yes", "", "", "yes"),
      Content(
          "صلاة العصر", "assets/IconLib/worship/2.png", "yes", "", "", "yes"),
      Content(
          "صلاة الفجر", "assets/IconLib/worship/4.png", "yes", "", "", "yes"),
      Content("الكعبة", "assets/IconLib/worship/5.jpg", "yes", "", "", "yes"),
      Content("صلاة ليلة القدر", "assets/IconLib/worship/6.jpg", "yes", "", "",
          "yes"),
      Content("دعاء", "assets/IconLib/worship/7.png", "yes", "", "", "yes"),
      Content("السلام", "assets/IconLib/worship/77.png", "yes", "", "", "yes"),
      Content(
          "الصلاة", "assets/IconLib/worship/pray.png", "yes", "", "", "yes"),
      Content(
          "صلاة القيام", "assets/IconLib/worship/8.png", "yes", "", "", "yes"),
      Content(
          "الصيام", "assets/IconLib/worship/fasting.png", "yes", "", "", "yes"),
      Content("ركوع", "assets/IconLib/worship/9.png", "yes", "", "", "yes"),
      Content("سجود", "assets/IconLib/worship/10.png", "yes", "", "", "yes"),
      Content("تكبير", "assets/IconLib/worship/11.png", "yes", "", "", "yes"),
      Content("التشهد", "assets/IconLib/worship/12.png", "yes", "", "", "yes"),
      Content("الطواف", "assets/IconLib/worship/13.png", "yes", "", "", "yes"),
    ]),
    lib("أشكال", "assets/IconLib/Shapes/shapes.png", "yes", [
      Content(
          "دائرة  ", "assets/IconLib/Shapes/circle.png", "yes", "", "", "yes"),
      Content(
          " مربع", "assets/IconLib/Shapes/square.png", "yes", "", "", "yes"),
      Content("معين", "assets/IconLib/Shapes/oval.png", "yes", "", "", "yes"),
      Content(
          "مثلث", "assets/IconLib/Shapes/tringle.png", "yes", "", "", "yes"),
      Content("نجمة", "assets/IconLib/Shapes/star.png", "yes", "", "", "yes"),
      Content("مستطيل", "assets/IconLib/Shapes/rectangle1.png", "yes", "", "",
          "yes")
    ]),
    lib("اتجاهات", "assets/IconLib/directione/postions.png", "yes", [
      Content("جنوب ", "assets/IconLib/directione/direction.png", "yes", "", "",
          "yes"),
      Content(
          "شرق", "assets/IconLib/directione/west.png", "yes", "", "", "yes"),
      Content(
          "غرب ", "assets/IconLib/directione/east.png", "yes", "", "", "yes"),
      Content("شمال ", "assets/IconLib/directione/direction (1).png", "yes", "",
          "", "yes"),
      //-------------------------------------------------------------------
      Content(
          "على  ", "assets/IconLib/directione/on.png", "yes", "", "", "yes"),
      Content(" مقابل", "assets/IconLib/directione/front.jpg", "yes", "", "",
          "yes"),
      Content(
          "أسفل", "assets/IconLib/directione/down.png", "yes", "", "", "yes"),
      Content(
          "يمين", "assets/IconLib/directione/right.png", "yes", "", "", "yes"),
      Content(
          "بين", "assets/IconLib/directione/between.png", "yes", "", "", "yes"),
      Content("يسار", "assets/IconLib/directione/left-arrow.png", "yes", "", "",
          "yes"),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Padding(
        padding: DeviceUtil.isTablet
            ? const EdgeInsets.only(top: 30, right: 20, left: 20)
            : const EdgeInsets.only(top: 15, right: 10, left: 10),
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
                              fontSize: DeviceUtil.isTablet ? 42 : 26,
                              color: maincolor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: DeviceUtil.isTablet ? 30 : 15,
                        ),
                        const Text("يمكنك التعديل لاحقاً",
                            style: TextStyle(fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: DeviceUtil.isTablet ? 200 : 150,
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
              padding: EdgeInsets.only(
                  top: DeviceUtil.isTablet ? 30 : 11, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  indexesChooese.isNotEmpty
                      ? Text(
                          "${indexesChooese.length}  من  ${chooseLibrary.length} ",
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 28 : 20,
                              fontWeight: FontWeight.bold),
                        )
                      : Container(),
                  InkWell(
                    onTap: () {
                      if (selectAl == 0) {
                        indexesChooese = [];
                        for (int i = 0; i < chooseLibrary.length; i++) {
                          setState(() {
                            indexesChooese.add(i);
                          });
                        }
                        setState(() {
                          selectAl = 1;
                        });
                      } else {
                        setState(() {
                          indexesChooese = [];
                          selectAl = 0;
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0.1),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Row(
                        children: [
                          Icon(
                            selectAl != 0
                                ? Icons.check_circle_outline
                                : Icons.circle_outlined,
                            size: DeviceUtil.isTablet ? 30 : 20,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            'تحديد الكل',
                            style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 20 : 15,
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
              flex: 7,
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
                              mainAxisSpacing: DeviceUtil.isTablet ? 10 : 4,
                              crossAxisSpacing: DeviceUtil.isTablet ? 10 : 4,
                              crossAxisCount:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? DeviceUtil.isTablet
                                          ? 5
                                          : 4
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
                                  padding: EdgeInsets.all(
                                      DeviceUtil.isTablet ? 8.0 : 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: greyColor),
                                      color: const Color.fromARGB(
                                              255, 255, 255, 255)
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              DeviceUtil.isTablet ? 27 : 20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.7),
                                          spreadRadius: 0,
                                          blurRadius: 7,
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
                                                      style: TextStyle(
                                                          fontSize: DeviceUtil
                                                                  .isTablet
                                                              ? 25
                                                              : 20,
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
                      SharedPreferences liblistChild =
                          await SharedPreferences.getInstance();
                      List<String> libstring = [];
                      int j = chooseLibrary.length;
                      for (var i = 0; i < j; i++) {
                        libstring.add(convertLibString(chooseLibrary[i]));
                      }
                      liblistChild.setStringList("liblistChild", libstring);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainChildPage(
                                    index: 0,
                                  )));
                    }
                  },
                  child: Image.asset(
                    "assets/uiImages/start.png",
                    height: DeviceUtil.isTablet ? 85 : 50,
                  ),
                ),
                Container(
                  height: DeviceUtil.isTablet ? 18 : 12,
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences liblistChild =
                        await SharedPreferences.getInstance();
                    List<String> libstring = [];
                    int j = chooseLibrary.length;
                    for (var i = 0; i < j; i++) {
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
                        fontSize: DeviceUtil.isTablet ? 20 : 17),
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
