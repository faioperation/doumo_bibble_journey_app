import 'package:bible_journey/features/bible/model/bible_model.dart';
import 'package:flutter/material.dart';
import '../screens/chapter_screen.dart';
import 'old_new_testiment_section.dart';

class BookSection extends StatefulWidget {
  final BibleBook book;
  final CollapseController controller;

  const BookSection({
    super.key,
    required this.book,
    required this.controller,
  });

  @override
  State<BookSection> createState() => _BookSectionState();
}

class _BookSectionState extends State<BookSection> {
  bool isExpanded = false;

  void toggleExpand() {
    if (!isExpanded) {
      widget.controller.closeAll();
      widget.controller.currentOpened =
          CollapseItem(notifier: () => setState(() => isExpanded = false));
    }

    setState(() => isExpanded = !isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.book.title),
            subtitle: Text("${widget.book.chapters} Chapters"),
            trailing: Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
            onTap: toggleExpand,
          ),

          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.book.chapters,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChapterScreen(
                            bookName: widget.book.title,
                            chapterNumber: i + 1,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xff83BF8B).withOpacity(.20),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text("${i + 1}"),
                    ),
                  );
                },

              ),
            ),
        ],
      ),
    );
  }
}
