import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epub_view/epub_view.dart';
import 'package:pdfrx/pdfrx.dart';
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
      final document = await PdfDocument.openFile(file.path);
      List<int>? coverBytes;
      
      double? aspectRatio;
      if (document.pages.isNotEmpty) {
        final page = document.pages[0];
        aspectRatio = page.width / page.height;

        // Use scale to get high quality cover relative to the page size
        final scale = 1.0; 
        final image = await page.render(
          width: (page.width * scale).toInt(),
          height: (page.height * scale).toInt(),
          backgroundColor: Colors.white.value, // pdfrx 2.x expects int?
        );
        
        if (image != null) {
           try {
             
             final int width = image.width;
             final int height = image.height;
             final pixels = image.pixels; // Uint8List
             
             // pdfrx usually returns BGRA or RGBA.
             final targetBytes = Uint8List(width * height * 4);
             for (int i = 0; i < width * height; i++) {
                final b = pixels[i * 4];
                final g = pixels[i * 4 + 1];
                final r = pixels[i * 4 + 2];
                final a = pixels[i * 4 + 3];
                
                targetBytes[i * 4] = r;
                targetBytes[i * 4 + 1] = g;
                targetBytes[i * 4 + 2] = b;
                targetBytes[i * 4 + 3] = a;
             }
             
             // Image 4.x uses named args and ByteBuffer usually
             final pdfImg = img.Image.fromBytes(width: width, height: height, bytes: targetBytes.buffer);
             coverBytes = img.encodeJpg(pdfImg);
           } catch(e) {
             print("Failed to encode PDF cover: $e");
           }
        }
      }
      
      int pageCount = document.pages.length;
      // document.dispose(); // pdfrx documents might need disposal? Usually handled by finalize or we should explicitly? 
      // PdfDocument.openFile returns object that should be disposed?
      // pdfrx PdfDocument has dispose.
      
      // Wait, we can't fully dispose if we want to return data? No, valid to dispose after read.
      // But verify API.
      // document.dispose(); 
      
      return BookMetadata(
        title: p.basenameWithoutExtension(file.path),
        author: 'Unknown',
        coverImage: coverBytes,
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
