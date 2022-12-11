// ignore_for_file: non_constant_identifier_names
String scoonAtLast(String input) {
  return "$input\u{0652}";
}

String harakatOnFirstWord(String input) {
  List<String> inputlist = input.split(" ");
  if (inputlist[0] == "بكم") {
    inputlist[0] = "بِكَمْ";
  } else if (inputlist[0] == "طيب") {
    inputlist[0] = "طييب";
  } else if (inputlist[0] == "اين") {
    inputlist[0] = "أَيْنَ";
  } else if (inputlist[0] == "كيف") {
    inputlist[0] = "كَيفَ";
  } else if (inputlist[0] == "السلام") {
    inputlist[0] = "السلامُ";
  } else if (inputlist[0] == "افتح") {
    inputlist[0] = "إِفْتَح";
  }
  ///////////////////////

  //////////////////
  else if (input.trim() == "أريد أن احجز موعد قريبا") {
    return "أُريدُ أَنْ أَحْجِزَ مَوْعِدً قَرِيبًا";
  } else if (input.trim() == "لدي الم شديد هنا") {
    return "لَدَيَّ أَلَمٌ شَديدٌ هُنَا";
  } else if (input.trim() == "أريد الإسعاف عاجلا") {
    return "أُريدُ الإِسْعافَ عَاجِلًا";
  } else if (input.trim() == "هل يوجد مستوصف قريب من هنا") {
    return "هَلْ يوجَدُ مُسْتوْصَفٌ قَريبٌ مِنْ هُنَا";
  } else if (input.trim() == "أريد صرف الدواء من فضلك") {
    return "أُريدُ صَرْفَ الدَّواءِ مِنْ فَضْلِكَ";
  } else if (input == "كم جرعة الدواء ومتى؟") {
    return "كَمْ جُرْعَةُ الدَّواءِ وَمَتَى ؟";
  } else if (input == "شكرا لك و أنا ممنون لك") {
    return "شُكْرًا لَكَ وَ أَنَا مَمْنونٌ لك";
  } else if (input == "اطلب الطبيب لي") {
    return "أُطْلبْ الطَّبيبَ لِ";
  }
  //////////////////////////
  else if (input == "هل قامت الصلاة") {
    return "هَلْ قَامَتْ الصَّلاةُ ";
  } else if (input.trim() == "أريد ان اتوضأ أين المواضئ") {
    return "أُريدُ اَنْ أَتَوَضَّأْ أَيْنَ الْمُوَاضِئ";
  } else if (input.trim() == "كم ركعة فاتتني") {
    return "كَمْ رَكْعَهْ فَاتَتْنِي";
  } else if (input.trim() == "أين يقع اقرب مسجد") {
    return "أَيْنَ يَقَعُ أقربُ مَسْجِد";
  } else if (input.trim() == "هل يوجد مدخل خاص للكراسي المتحركة ؟") {
    return "هَلْ يوجَدُ مَدْخَلٌ خاصٌّ لِلْكَرَاسِيِّ المُتَحَرِّكَةِ ؟ ";
  }
  ///////////////////////////////////////////////////
  else if (input == "كم سعر هذه الوجبة؟") {
    return "كَمْ سِعْرُ هَذِهِ الوَجْبَه";
  } else if (input == "هل لديكم توصيل للمنازل؟") {
    return "هَلْ لَدَيْكُمْ تَوْصيلٌ لِلْمَنَازِل";
  } else if (input ==
      "أنا أستخدم برنامج على الهاتف للتواصل معك، فأرجو أن تتساعد معي") {
    return "أَنَا أَسْتَخْدِمُ بَرْنامَجً عَلَى اَلْهاتِفِ لِلتَّوَاصُلِ مَعَكَ ، فَأَرْجُو أَنْ تَتَساعَدَ مَعِي";
  } else if (input == "الطعم لذيذ شكرًا") {
    return "الطَّعْمُ لَذيذٌ شُكْرًا";
  } else if (input == "هل لديكم شبكة للدفع؟") {
    return "هَلْ لَدَيْكُمْ شَبَكَةٌ لِلدَّفْعِ ؟";
  } else if (input == "كم مجموع الطعام؟") {
    return "كَمْ مَجْموعُ الطَّعام";
  } else if (input == "أريد الباقي لوسمحت") {
    return "أُريدُ الْبَاقِي لَو سَمحْتْ";
  } else if (input == "أبحث عن مطعم شعبي قريب من هنا") {
    return "أَبْحَثُ عَنْ مَطْعَمٍ شَعْبيٍّ قَريبٍ مِنْ هُنَا ";
  } else if (input == "من فضلك إقرأ قائمة الطعام لي") {
    return "مِنْ فَضْلِكَ إِقْرَأْ قائِمَةَ الطَّعامِ لِ";
  }
  /////////////////////////
  else if (input == "الأجواء معتدلة وممتعة هنا") {
    return "الأَجْواءُ مُعْتَدِلَةٌ وَمُمْتِعَةٌ هُنَا";
  } else if (input == "أريد أن أحجز تذكرة") {
    return "أُريدُ أَنْ أَحْجِزَ تَذْكِره";
  } else if (input == "أريد أن أسجل الحضور") {
    return "أُريدُ أَنْ أُسَجِّلَ الحُضور";
  } else if (input == "أريد الحصول على تخفيض ذوي الاعاقة") {
    return "أُريدُ الحُصولَ عَلَى تَخْفيضِ ذَوِي الإِعاقَه";
  } else if (input == "كم تكلفة السفر") {
    return "كَمْ تَكْلِفَةُ السَّفَر";
  } else if (input == "أبحث عن مساعد ليساعدني في اتمام سفري") {
    return "أَبْحَثُ عَنْ مُساعِدٍ ليُساعِدَني فِي إِتْمامِ سَفَرِي";
  } else if (input == "هل بوابة الرحلة مفتوحة؟") {
    return "هَلْ بَوّابَةُ الرِّحْلَةِ مَفْتوحَه";
  } else if (input == "هذه أمتعتي أريدك أن تساعدني") {
    return "هَذِهِ أَمْتِعَتي أُريدُك أَنْ تُساعِدني";
  } else if (input == "شكرًا لك وأنا ممنون لك") {
    return "شُكْرًا لَكَ وَأَنَا مَمْنونٌ لَكَ";
  }
  //////////////////////////////////
  else if (input == "كم سعر هذا؟") {
    return "كَم سِعْرُ هَاذَا";
  } else if (input == "السعر مرتفع جدًا") {
    return "السِّعْرُ مُرْتَفِعٌ جِدًّا";
  } else if (input == "هل لديكم فرع آخر؟") {
    return "هَلْ لَدَيْكُمْ فَرْعٌ آخَر";
  } else if (input == "أريد خضراوات طازجة") {
    return "أُريدُ خَضْراواتٍ طازَجَه";
  } else if (input == "هل لديكم تخفيضات؟") {
    return "هَلْ لَدَيْكُمْ تَخْفِيضَات";
  } else if (input == "أين أجد قسم الملابس؟") {
    return "أَيْنَ أَجِدُ قِسْمَ المَلابِس";
  } else if (input == "أريد أن تساعدني في الحصول على القطع في الرف المرتفع") {
    return "أُريدُ أَنْ تُساعِدَني فِي الحُصولِ عَلَى القِطَعِ فِي الرَّفِ المُرْتَفِع";
  } else if (input == "لقد سقط هذا مني أرجوك أحضره") {
    return "لَقَدْ سَقَطَ هَذَا مِنِّي أَرْجوكَ أَحْضِرَه";
  } else if (input == "أريد أن أدفع المبلغ تفضل") {
    return "أُريدُ أَنْ أَدْفَعَ المَبْلَغَ تَفَضل";
  } else if (input == "أريد إرجاع هذا لأنه لا يناسبني") {
    return "أُريدُ إِرْجاعَ هَذَا لِأَنَّهُ لَا يُنَاسِبُنِي";
  }
  /////////////////////
  else if (input == "اهلا وسهلا ") {
    return "اهْلًا وَسَهْلًا";
  } else if (input == "مرحبا حياك الله ") {
    return "مَرْحَبًا حَيَاكَ اللَّه ";
  } else if (input == "وعليكم السلام ") {
    return "وَعَلَيْكُمْ السَّلَام ";
  } else if (input == "سعدت بالحديث معك مع السلامة ") {
    return "سَعَدْت بِالْحَدِيثِ مَعَك مَعَ السَّلَامَه";
    ////////////////
  } else if (input == "أستاذ أنا لم أفهم هذه المسألة") {
    return "أُسْتَاذ ........ أَنَا لَمْ أَفْهَمْ هَذِهِ الْمَسْأَلَه";
  } else if (input == "أريد أن أحل هذه المسألة") {
    return "أُرِيدُ أَنْ أَحِلَ هَذِهْ الْمَسْأَلَهْ";
  } else if (input == "لقد انتهيت") {
    return "لَقَدْ انْتَهَيْت";
  } else if (input == "أريد الخروج من الفصل") {
    return "أُرِيدُ الْخُرُوج مِنْ الْفَصْل";
  } else if (input == "كم درجة الاختبار؟") {
    return "كَمْ دَرَجَةُ الِاخْتِبَارْ؟";
  } else if (input == "متى ينتهي الدوام؟") {
    return "مَتَّى يَنْتَهِي الدَّوَامْ؟";
  } else if (input ==
      "أريد أن تساعدني في كتابة عبارات جديدة لاستخدامها في المدرسة") {
    return "أُرِيدُ أَنْ تُسَاعدَنِي فِي كِتَابَةِ عِبَارَاتٍ جَدِيدَةٍ لِاسْتِخْدَامهَا فِي المَدْرَسَهْ";
  } else if (input == "إلى اللقاء، مع السلامة") {
    return "إلَى اللِّقَاءِ،.. مَعَ السَّلَامَه";
  } else if (inputlist[0] == "مسطرة") {
    inputlist[0] = "مِسْطَرَةٌ";
  } else if (inputlist[0] == "دباسة") {
    inputlist[0] = "دبَّاسَه";
  } else if (inputlist[0] == "ملصقات") {
    inputlist[0] = "مُلصَقَات";
  } else if (inputlist[0] == "مقص") {
    inputlist[0] = "مَقَص";
  } else if (inputlist[0] == "قلم رصاص") {
    inputlist[0] = "قَلْمْ رَصَاص";
  } else if (inputlist[0] == "مقلمة") {
    inputlist[0] = "مِقْلَمَهْ ";
  } else if (inputlist[0] == "كرسي") {
    inputlist[0] = "كُرْسِي ";
  } else if (inputlist[0] == "قلم") {
    inputlist[0] = "قَلَمْ ";
  } else if (inputlist[0] == "معجم") {
    inputlist[0] = "مُعْجَمْ ";
  } else if (inputlist[0] == "ممحاة") {
    inputlist[0] = "مِمْحَاهْ ";
  }
  ////////////////////////
  //العمل
  else if (input == "أين مكتب العمل؟ ") {
    return "أَيْنَ مَكْتَبُ العَمَلْ ؟";
  } else if (input.trim() == "أريد السكرتير") {
    return "أُريدُ السِّكِرِتيرْ";
  } else if (input.trim() == "أنا ابحث عن عمل يناسبني") {
    return "أَنَا أبْحَثُ عَنْ عَمَلٍ يُنَاسِبُنِي";
  } else if (input == "هل انتهى الدوام ؟ ") {
    return "هَلْ انْتَهَى الدَّوَامْ";
  } else if (input == "ماهي البيانات المطلوبة") {
    return "ماهي البَيَانَاتُ المَطْلوبَة";
  }
//
  //عام
  else if (input.trim() == "أنا مشغول حاليا") {
    return "أَنَا مَشْغولٌ حاليًّا";
  } else if (input == "إفتح النور لو سمحت ") {
    return "اِفْتَحْ النّورَ لَوْ سَمَحْتْ";
  } else if (input.trim() == "اغلق النور لو سمحت") {
    return "أَغْلِقْ النّورَ لَوْ سَمَحْتْ";
  } else if (input.trim() == "أنا سعيد بحضورك") {
    return "أَنَا سَعيدٌ بِحُضورِكْ";
  } else if (input.trim() == "عذرا أين دورة المياه؟") {
    return "عُذْرًا أَيْنَ دَوْرَةُ اَلْمياهْ ؟";
  } else if (input.trim() == "كل عام وأنتم بخير") {
    return "كُلُّ عَامٍ وَأَنْتُمْ بِخَيْرْ";
  } else if (input.trim() == "نعم أريده") {
    return "نَعَمْ أُرِيدُهْ";
  } else if (input.trim() == "هذا الموقف خاص بذوي الإعاقة") {
    return "هَذَا المَوْقِفُ خاصٌّ بِذَوِي الإِعاقَهْ";
  } else if (input.trim() == "أريد ان أتوضأ وأصلي") {
    return "أُريدُ اَنْ أَتَوَضَّأَ وَأُصَلِّي";
  } else if (input == "أين المفتاح ؟ أنا لا أجده") {
    return "أَيْنَ المِفْتاحُ ؟ أَنَا لَا أَجِدُهْ";
  } else if (input == "تفضل معي الى البيت") {
    return "تَفَضلْ مَعِي إلى البَيْتْ";
  }
  return inputlist.join(" ");
}

String putDot(String input) {
//this function adds a dot(.) before some words to enhance the pronounciation
  List<String> spliteInput = input.split(" ");
  String output = "";
  List<String> goals = [
    "و",
    "بعد",
    "خلال",
    "قبل",
    "لكن",
    "لان",
    "لأن",
    "منذ",
    "كما",
    "اثر",
    "إثر",
    "عندما",
    "بسبب",
    "فيما",
    "عند",
    "ثم",
    "او",
    "أو",
    "اذا",
    "إذا",
    "حيث",
    "رغم",
    "حتى",
    "اما",
    "أما",
    "إما",
    "خصوصا",
    "بعدما",
    "اذ",
    "إذ",
    "مما",
    "ايضا",
    "أيضا",
    "بينما",
    "بل",
    "بهدف",
    "بالتالي",
    "جراء",
    "انما",
    "إنما",
    "لو",
    "كذلك",
    "عقب",
    "لاسيما",
    "بفضل",
    "قبيل",
    "بالرغم",
    "لكي",
    "بغية",
    "طالما",
    "بالمقابل",
    "الا",
    "إلا",
    "نتيجة",
    "حال",
    "حينها",
    "كي",
    "وقبل",
    "كأن",
    "بحيث",
    "حين",
    "برغم",
    "بالرغم",
    "كلما",
    "لذا",
    "لذلك",
    "لولا",
    "كيف",
    "هل",
    "كم",
    "متى",
    "اين",
    "أين",
    "بكم",
    "ممكن",
    "لماذا"
  ];
  for (int i = 0; i < spliteInput.length; i++) {
    if ((i != 0) && (goals.contains(spliteInput[i]))) {
      //if it is the word and not at the begining of the sentence
      spliteInput.insert((i), ".");
      i++;
      continue;
    }
  }
  output = spliteInput.join(" ");
  return output;
}

String pronounceShaddaAndroid(String input) {
  // this function replace each shadda with the letter twice to pronounce it
  List<String> spliteInput = input.split(" ");
  String word = "";
  String output = "";
  String finalWord = "";
  for (int i = 0; i < spliteInput.length; i++) {
    if (spliteInput[i].contains("\u{0651}") || spliteInput[i].contains("ّ")) {
      word = spliteInput[i];
      List<String> spliteWord = word.split("");
      for (int j = 0; j < spliteWord.length; j++) {
        if (spliteWord[j] == "\u{0651}" || spliteWord[j] == "ّ") {
          String doubledLetter = "";
          if (j == spliteWord.length - 1) {
            //if shadda is last letter
            // haraka = "َ";
            doubledLetter = spliteWord[j - 1];
            spliteWord[j] = doubledLetter;
            finalWord = spliteWord.join("");
            output += finalWord;
          } else if ((j + 1 <= spliteWord.length - 1) &&
              (!RegExp(r'^[أ-ي]+$').hasMatch(spliteWord[j + 1]))) {
            //if after shadda is haraka

            List<String> startTemp = spliteWord.sublist(0, j + 2);
            List<String> endTemp = spliteWord.sublist(j + 2);
            doubledLetter = startTemp[startTemp.length - 3];
            startTemp[startTemp.length - 2] = doubledLetter;
            startTemp.removeAt(startTemp.length - 1);
            List<String> newSplitedWord = startTemp + endTemp;
            finalWord = newSplitedWord.join("");
            output += finalWord;
          } else if ((j + 1 <= spliteWord.length - 1) &&
              (RegExp(r'^[أ-ي]+$').hasMatch(spliteWord[j + 1]))) {
            //if after shadda is letter

            List<String> startTemp = spliteWord.sublist(0, j + 1);
            List<String> endTemp = spliteWord.sublist(j + 1);
            doubledLetter = startTemp[startTemp.length - 2];
            startTemp[startTemp.length - 1] = doubledLetter;
            List<String> newSplitedWord = startTemp + endTemp;
            finalWord = newSplitedWord.join("");
            output += finalWord;
          }
        }
      }
    } else {
      output += " ${spliteInput[i]} ";
    }
  }
  return output;
}

String preRplace(String input) {
//this function replace ف with في and ي with يا and ع with  على
  List<String> spliteInput = input.split(" ");
  String output = "";
  for (int i = 0; i < spliteInput.length; i++) {
    if (spliteInput[i] == "ي") {
      spliteInput[i] = "يا";
    }
    if (spliteInput[i] == "ع") {
      spliteInput[i] = "على";
    }
    if (spliteInput[i] == "ف") {
      spliteInput[i] = "في";
    }
  }
  output = spliteInput.join(" ");
  return output;
}

String pronounceShaddaIOS(String input) {
  // this function replace each shadda with the letter twice to pronounce it
  List<String> spliteInput = input.split(" ");
  String word = "";
  String output = "";
  String finalWord = "";
  String haraka = "ْ";

  for (int i = 0; i < spliteInput.length; i++) {
    word = spliteInput[i];
    List<String> spliteWord = word.split("");
    for (int j = 0; j < spliteWord.length; j++) {
      if (spliteWord[j] == "\u{0651}" || spliteWord[j] == "ّ") {
        //if what at j is shadda
        String TripleLetter = "";

        if (j == spliteWord.length - 1) {
          //if shadda is last letter
          TripleLetter = spliteWord[j - 1];
          spliteWord[j] = haraka;
          spliteWord.add(TripleLetter);
          spliteWord.add(haraka);
          spliteWord.add(TripleLetter);
          spliteWord.add(haraka);
          finalWord = spliteWord.join("");
          output += finalWord;
        } else if ((j + 1 <= spliteWord.length - 1) &&
            (!RegExp(r'^[أ-ي]+$').hasMatch(spliteWord[j + 1]))) {
          //if after shadda is haraka
          List<String> startTemp = spliteWord.sublist(0, j + 2);
          List<String> endTemp = spliteWord.sublist(j + 2);
          // haraka = startTemp[startTemp.length-1];//last char of startTemp
          TripleLetter = startTemp[startTemp.length - 3];
          startTemp[startTemp.length - 2] = "ْ";
          startTemp[startTemp.length - 1] = TripleLetter;
          startTemp.add(haraka);
          startTemp.add(TripleLetter);
          startTemp.add(haraka);
          List<String> newSplitedWord = startTemp + endTemp;
          finalWord = newSplitedWord.join("");
          output += finalWord;
        } else if ((j + 1 <= spliteWord.length - 1) &&
            (RegExp(r'^[أ-ي]+$').hasMatch(spliteWord[j + 1]))) {
          //if after shadda is letter
          List<String> startTemp = spliteWord.sublist(0, j + 1);
          List<String> endTemp = spliteWord.sublist(j + 1);
          TripleLetter = startTemp[startTemp.length - 2];
          startTemp[startTemp.length - 1] = haraka;
          startTemp.add(TripleLetter);
          startTemp.add(haraka);
          startTemp.add(TripleLetter);
          startTemp.add(haraka);
          List<String> newSplitedWord = startTemp + endTemp;
          finalWord = newSplitedWord.join("");
          output += finalWord;
        }
      }
    }
  }
  return output;
}

String TurnTaaToHaa(String input) {
//this function turns ة into ه in the  word
  String output = "";
  List<String> spliteInput = input.split(" ");

  String word = spliteInput[spliteInput.length - 1];
  if (word[word.length - 1] == "ة") {
    word = word.substring(0, word.length - 1);
    word += "ه";
  } else if (word[word.length - 2] == "ة") {
    word = word.substring(0, word.length - 2);
    word += "ه";
  }
  spliteInput[spliteInput.length - 1] = word;
  output = spliteInput.join(" ");

  return output;
}

String TurnAToAA(String input) {
//this function turn the first letter that is ا into أ in the first word in a sentence
  List<String> spliteInput = input.split(" "); //splite the sentence
  String firstWord = spliteInput[0];
  List<String> letters = firstWord.split("");
  String output = "";
  if (letters[0] == "ا") {
    letters[0] = "أ";
  }
  spliteInput[0] = letters.join("");
  output = spliteInput.join(" ");
  return output;
}
