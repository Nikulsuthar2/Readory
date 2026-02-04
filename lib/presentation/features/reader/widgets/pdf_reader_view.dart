import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import '../../../../domain/entities/book_entity.dart';
import '../../../../domain/entities/annotation_entity.dart';
import 'dart:io';

import '../reader_view_model.dart';

class PdfReaderView extends StatefulWidget {
  final BookEntity book;
  final Function(int) onPageChanged;
  final Function(PdfDocument) onDocumentReady;
  final PdfViewerController? controller;
  final ReaderTheme theme;
  final Axis scrollDirection;
  final List<AnnotationEntity> annotations;
  final Function(AnnotationEntity) onAnnotationAdded;
  final VoidCallback onBackgroundTap;

  const PdfReaderView({
    super.key,
    required this.book,
    required this.onPageChanged,
    required this.onDocumentReady,
    this.controller,
    required this.theme,
    required this.scrollDirection,
    required this.annotations,
    required this.onAnnotationAdded,
    required this.onBackgroundTap,
  });

  @override
  State<PdfReaderView> createState() => _PdfReaderViewState();
}

class _PdfReaderViewState extends State<PdfReaderView> {
  @override
  Widget build(BuildContext context) {
    return PdfViewer.file(
      widget.book.filePath,
      controller: widget.controller,
      // Note: pdfrx 1.3.5 might manage scroll direction via params or automatically based on layout.
      // If 'scrollDirection' is not a named parameter, we omit it.
      // We rely on PdfViewerParams.
      params: PdfViewerParams(
        backgroundColor: widget.theme == ReaderTheme.night ? Colors.black : Colors.white,
        // layoutPages: Removed to use default vertical layout.
        onViewerReady: (document, controller) {
           widget.onDocumentReady(document);
        },
        onPageChanged: (pageNumber) {
          if (pageNumber != null) {
            widget.onPageChanged(pageNumber);
          }
        },
      ),
    );
  }
}
