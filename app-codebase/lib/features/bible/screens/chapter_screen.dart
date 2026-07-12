import 'package:flutter/material.dart';
import '../model/bible_model.dart';
import '../services/bible_api_service.dart';

class ChapterScreen extends StatefulWidget {
  final String bookName;
  final int chapterNumber;

  const ChapterScreen({
    super.key,
    required this.bookName,
    required this.chapterNumber,
  });

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  late Future<List<Verse>> futureVerses;

  @override
  void initState() {
    super.initState();
    futureVerses = BibleApiService.fetchChapter(
      bookName: widget.bookName,
      chapter: widget.chapterNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F5F2),

      appBar: AppBar(
        backgroundColor: const Color(0xffF8F5F2),
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.bookName),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "Chapter ${widget.chapterNumber}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: FutureBuilder<List<Verse>>(
              future: futureVerses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error loading chapter"));
                }

                final verses = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: verses.length,
                  itemBuilder: (context, index) {
                    final verse = verses[index];
                    return Container(
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Verse ${verse.verse}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            verse.text,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.5,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
