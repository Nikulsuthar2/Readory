import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../domain/entities/book_entity.dart';
import '../../../../domain/entities/annotation_entity.dart';
import 'dart:io';

import '../reader_view_model.dart';

class PdfReaderView extends StatefulWidget {
  final BookEntity book;
  final Function(int) onPageChanged;
  final Function(PdfDocumentLoadedDetails) onDocumentReady;
  final PdfViewerController? controller;
  final ReaderTheme theme;
  final Function(AnnotationEntity) onAnnotationAdded;
  final List<AnnotationEntity> annotations;
  final Axis scrollDirection;
  final VoidCallback? onBackgroundTap;

  const PdfReaderView({
    super.key,
    required this.book,
    required this.onPageChanged,
    required this.onDocumentReady,
    required this.onAnnotationAdded,
    this.annotations = const [],
    this.controller,
    this.theme = ReaderTheme.day,
    this.scrollDirection = Axis.vertical,
    this.onBackgroundTap,
  });

  @override
  State<PdfReaderView> createState() => _PdfReaderViewState();
}

class _PdfReaderViewState extends State<PdfReaderView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    // Map theme to ColorFilter
    ColorFilter? colorFilter;
    switch (widget.theme) {
      case ReaderTheme.night:
        colorFilter = const ColorFilter.matrix([
           -1,  0,  0, 0, 255,
            0, -1,  0, 0, 255,
            0,  0, -1, 0, 255,
            0,  0,  0, 1,   0,
        ]);
        break;
      case ReaderTheme.sepia:
        colorFilter = const ColorFilter.matrix([
           0.393, 0.769, 0.189, 0, 0,
           0.349, 0.686, 0.168, 0, 0,
           0.272, 0.534, 0.131, 0, 0,
           0,     0,     0,     1, 0,
        ]);
        break;
      case ReaderTheme.twilight:
        colorFilter = const ColorFilter.matrix([
           1,     0,     0,     0, 0,
           0,     0.9,   0,     0, 0,
           0,     0,     0.8,   0, 0,
           0,     0,     0,     1, 0,
        ]);
        break;
      case ReaderTheme.day:
      default:
        colorFilter = null;
        break;
    }

    Widget viewer = SfPdfViewer.file(
      File(widget.book.filePath),
      key: _pdfViewerKey,
      controller: _controller,
      canShowScrollHead: false,
      enableTextSelection: true,
      scrollDirection: widget.scrollDirection == Axis.horizontal 
          ? PdfScrollDirection.horizontal 
          : PdfScrollDirection.vertical,
      pageLayoutMode: widget.scrollDirection == Axis.horizontal
          ? PdfPageLayoutMode.single
          : PdfPageLayoutMode.continuous,
      onPageChanged: (PdfPageChangedDetails details) {
        widget.onPageChanged(details.newPageNumber);
      },
      onDocumentLoaded: (PdfDocumentLoadedDetails details) {
        widget.onDocumentReady(details);
        // Jump to last read page
        if (widget.book.lastReadPage > 1) {
           _controller.jumpToPage(widget.book.lastReadPage);
        }
      },
      onTap: (PdfGestureDetails details) {
        widget.onBackgroundTap?.call();
      },
      onTextSelectionChanged: (PdfTextSelectionChangedDetails details) {
        if (details.selectedText != null && details.selectedText!.isNotEmpty) {
           // Handle text selection if needed, generally Syncfusion handles the menu
        }
      },
    );

    if (colorFilter != null) {
      return ColorFiltered(
        colorFilter: colorFilter,
        child: viewer,
      );
    }
    
    return viewer;
  }
}
