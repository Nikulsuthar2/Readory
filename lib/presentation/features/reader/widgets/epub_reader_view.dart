import 'dart:io';
import 'package:flutter/material.dart';
import 'package:epub_view/epub_view.dart';
import '../../../../domain/entities/book_entity.dart';

class EpubReaderView extends StatefulWidget {
  final BookEntity book;

  const EpubReaderView({super.key, required this.book});

  @override
  State<EpubReaderView> createState() => _EpubReaderViewState();
}

class _EpubReaderViewState extends State<EpubReaderView> {
  late EpubController _epubController;

  @override
  void initState() {
    super.initState();
    _epubController = EpubController(
      document: EpubDocument.openFile(File(widget.book.filePath)),
      // epub_view doesn't support initialCfi directly in constructor easily in all versions, 
      // check if we need to jump after load.
    );
  }

  @override
  void dispose() {
    _epubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EpubView(
      controller: _epubController,
      onDocumentLoaded: (document) {
         // jump to last read if needed
      },
      onChapterChanged: (value) {
        // TODO: update progress
      },
    );
  }
}
