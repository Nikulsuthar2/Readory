import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epub_view/epub_view.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as img; 
import '../../data/models/book_model.dart';

final metadataServiceProvider = Provider<MetadataService>((ref) {
  return MetadataService();
});

class MetadataService {
  Future<BookMetadata> extractMetadata(File file) async {
    final ext = p.extension(file.path).toLowerCase();
    
    if (ext == '.epub') {
      return _extractEpubMetadata(file);
    } else if (ext == '.pdf') {
      return _extractPdfMetadata(file);
    } else {
      return BookMetadata(
        title: p.basenameWithoutExtension(file.path),
        author: 'Unknown',
        format: BookFormat.pdf, // Default fallback
      );
    }
  }

  Future<BookMetadata> _extractEpubMetadata(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final epubBook = await EpubReader.readBook(bytes);
      
      List<int>? coverBytes;
      if (epubBook.CoverImage != null) {
         try {
           coverBytes = img.encodePng(epubBook.CoverImage!);
         } catch(e) {
           print("Failed to encode EPUB cover: $e");
         }
      }
      
      return BookMetadata(
        title: epubBook.Title ?? p.basenameWithoutExtension(file.path),
        author: epubBook.Author ?? 'Unknown',
        coverImage: coverBytes,
        format: BookFormat.epub,
      );
    } catch (e) {
      print('Error parsing EPUB ${file.path}: $e');
      return BookMetadata(
        title: p.basenameWithoutExtension(file.path),
        author: 'Unknown',
        format: BookFormat.epub,
      );
    }
  }

  Future<BookMetadata> _extractPdfMetadata(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final document = PdfDocument(inputBytes: bytes);
      List<int>? coverBytes;
      double? aspectRatio;

      // Cover extraction using Syncfusion is limited in current free community version directly to image bytes 
      // without extra work or UI context? 
      // Actually PdfDocument doesn't typically render pages to images in the non-UI package.
      // We might need to skip cover generation for PDF for now or use a different approach.
      // Syncfusion PDF package creates/edits PDFs, it doesn't always render them to bitmaps (that's what the Viewer does).
      // If we really need covers, we might need a separate lightweight renderer or plugins.
      // However, since we removed pdfrx, we lost that ability.
      // Decision: For now, return metadata without cover or use a placeholder approach.
      // If the user insists on covers, we might need `pdf_render` or similar alongside Syncfusion, 
      // BUT `syncfusion_flutter_pdfviewer` might have helpers? No. 
      
      // Let's just get page count and info for now.
      
      if (document.pages.count > 0) {
          final page = document.pages[0];
          aspectRatio = page.size.width / page.size.height;
      }
      
      int pageCount = document.pages.count;
      document.dispose();

      return BookMetadata(
        title: p.basenameWithoutExtension(file.path),
        author: 'Unknown',
        coverImage: null, // Cover extraction temporarily disabled
        format: BookFormat.pdf,
        totalPages: pageCount,
        aspectRatio: aspectRatio,
      );
    } catch (e) {
       print('Error parsing PDF ${file.path}: $e');
       return BookMetadata(
        title: p.basenameWithoutExtension(file.path),
        author: 'Unknown',
        format: BookFormat.pdf,
      );
    }
  }
}

class BookMetadata {
  final String title;
  final String author;
  final List<int>? coverImage;
  final BookFormat format;
  final int totalPages;
  final double? aspectRatio;

  BookMetadata({
    required this.title,
    required this.author,
    this.coverImage,
    required this.format,
    this.totalPages = 0,
    this.aspectRatio,
  });
}
