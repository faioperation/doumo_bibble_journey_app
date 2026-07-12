class Verse {
  final int verse;
  final String text;

  Verse({
    required this.verse,
    required this.text,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      verse: json['verse']  ,
      text: json['text'],
    );
  }
}

class BibleBook {
  final String title;
  final String apiKey;
  final int chapters;

  BibleBook({
    required this.title,
    required this.apiKey,
    required this.chapters,
  });
}

