import 'package:easy_localization/easy_localization.dart';
import 'dart:ui';
import '../model/bible_model.dart';

class CollapseController {
  CollapseItem? currentOpened;

  void closeAll() {
    currentOpened?.notifier();
    currentOpened = null;
  }
}

class CollapseItem {
  final VoidCallback notifier;
  CollapseItem({required this.notifier});
}

final oldTestamentSections = {
  "sections.pentateuch".tr(): [
    BibleBook(title: "Genesis", apiKey: "genesis", chapters: 50),
    BibleBook(title: "Exodus", apiKey: "exodus", chapters: 40),
    BibleBook(title: "Leviticus", apiKey: "leviticus", chapters: 27),
  ],
  "sections.historical".tr(): [
    BibleBook(title: "Joshua", apiKey: "joshua", chapters: 24),
    BibleBook(title: "Judges", apiKey: "judges", chapters: 21),
  ],
  "sections.poetic".tr(): [
    BibleBook(title: "Job", apiKey: "job", chapters: 42),
    BibleBook(title: "Psalms", apiKey: "psalms", chapters: 150),
    BibleBook(title: "Proverbs", apiKey: "proverbs", chapters: 31),
  ],
};

final newTestamentSections = {
  "sections.gospels".tr(): [
    BibleBook(title: "Matthew", apiKey: "matthew", chapters: 28),
    BibleBook(title: "Mark", apiKey: "mark", chapters: 24),
    BibleBook(title: "Luke", apiKey: "luke", chapters: 24),
  ],
  "sections.history".tr(): [
    BibleBook(title: "Acts", apiKey: "acts", chapters: 24),
  ],
  "sections.pauline".tr(): [
    BibleBook(title: "Romans", apiKey: "romans", chapters: 16),
    BibleBook(title: "1 Corinthians", apiKey: "1corinthians", chapters: 16),
    BibleBook(title: "2 Corinthians", apiKey: "2corinthians", chapters: 13),
  ],
};
