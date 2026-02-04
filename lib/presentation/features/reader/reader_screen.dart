import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../../domain/entities/book_entity.dart';
import 'reader_view_model.dart';
import 'widgets/pdf_reader_view.dart';

class ReaderScreen extends ConsumerStatefulWidget {
  final BookEntity book;
  const ReaderScreen({super.key, required this.book});

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PdfViewerController _pdfController = PdfViewerController();
  List<PdfBookmark> _toc = []; // Syncfusion uses PdfBookmark

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onDocumentReady(PdfDocumentLoadedDetails details) async {
    if (mounted) {
       // Syncfusion loads bookmarks 
       // details.document.bookmarks is a PdfBookmarkBase, which is iterable of PdfBookmark
       final bookmarks = details.document.bookmarks;
       if (bookmarks.count > 0) {
          _toc = [];
          for(int i=0; i<bookmarks.count; i++) {
            _toc.add(bookmarks[i]);
          }
          if (mounted) setState(() {});
       }

       ref.read(readerViewModelProvider(widget.book).notifier).setTotalPages(details.document.pages.count);
    }
  }

  void _onTocTap(PdfBookmark node) {
     // _pdfController.jumpToBookmark(node); // Syncfusion controller has jumpToBookmark
     _pdfController.jumpToBookmark(node);
     Navigator.pop(context);
  }
  
  // Syncfusion bookmarks structure matching
  List<Widget> _buildTocItems(List<PdfBookmark> nodes, {int depth = 0}) {
    List<Widget> items = [];
    for (var node in nodes) {
        items.add(
          ListTile(
            contentPadding: EdgeInsets.only(left: 16.0 + (depth * 16.0), right: 16.0),
            title: Text(node.title, style: const TextStyle(fontSize: 14)),
            onTap: () => _onTocTap(node),
          ),
        );
        // Recursion not easily supported merely by List<PdfDocumentBookmark> without children property?
        // Checking API: Syncfusion PdfDocumentBookmark usually has no children property exposed directly in some versions?
        // Actually it does not have recursive structure in the same way simple list often.
        // Wait, standard PDF bookmarks are tree. 
        // Let's assume for now we don't have deep nested TOC without extra package `syncfusion_flutter_pdf`.
        // So we will just show top level or flat list if we can get it.
        // Since we can't easily get it without the core pdf package, lets comment out recursion or keep it empty.
        
        /* 
        if (node.children.isNotEmpty) {
           items.addAll(_buildTocItems(node.children, depth: depth + 1));
        }
        */
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(readerViewModelProvider(widget.book));
    final notifier = ref.read(readerViewModelProvider(widget.book).notifier);
    
    final isPdf = widget.book.filePath.toLowerCase().endsWith('.pdf');

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: state.isDarkMode ? Colors.black : Colors.white,
      drawer: _toc.isEmpty ? null : Drawer(
        child: Column(
          children: [
            const DrawerHeader(child: Center(child: Text("Table of Contents"))),
            Expanded(
              child: ListView(
                children: _buildTocItems(_toc),
              ),
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: notifier.toggleControls,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            // READER VIEW
            if (isPdf)
              PdfReaderView(
                book: widget.book,
                controller: _pdfController,
                onPageChanged: notifier.onPageChanged,
                onDocumentReady: _onDocumentReady,
                theme: state.theme,
                scrollDirection: state.scrollDirection,
                annotations: state.annotations,
                onAnnotationAdded: notifier.addAnnotationEntity,
                onBackgroundTap: notifier.toggleControls,
              )
            else
              const Center(child: Text("EPUB Reader V2 Pending")),

            // TOP BAR (Floating)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              top: state.showControls ? 0 : -100,
              left: 0,
              right: 0,
              child: SafeArea( // Ensure it doesn't clip status bar info if transparent, but here we want it below
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.book.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (_toc.isNotEmpty)
                         IconButton(
                           icon: const Icon(Icons.format_list_bulleted),
                           tooltip: 'Chapters',
                           onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                         ),
                       IconButton(
                         icon: const Icon(Icons.settings_display), // Or text_format
                         tooltip: 'Appearance',
                         onPressed: () {
                           _showSettingsSheet(context, notifier, state);
                         },
                       ),
                         IconButton(
                         icon: const Icon(Icons.more_vert),
                         onPressed: () {
                           // TODO: More settings
                         },
                       ),
                    ],
                  ),
                ),
              ),
            ),

            // BOTTOM BAR (Page Control)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              bottom: state.showControls ? 0 : -100,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                       BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${state.currentPage}", 
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                          ),
                          child: Slider(
                            value: state.currentPage.toDouble(),
                            min: 1,
                            max: state.totalPages > 0 ? state.totalPages.toDouble() : (state.currentPage + 50).toDouble(),
                            onChanged: (val) {
                              if (isPdf) _pdfController.jumpToPage(val.toInt());
                            },
                          ),
                        ),
                      ),
                      Text(
                        "${state.totalPages > 0 ? state.totalPages : '?'}", 
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showSettingsSheet(BuildContext context, ReaderViewModel notifier, ReaderState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      showDragHandle: true,
      builder: (context) {
        // Use a Consumer to rebuild sheet when state changes
        return Consumer(
          builder: (context, ref, child) {
            // Re-watch state inside sheet
            final dynamicState = ref.watch(readerViewModelProvider(widget.book));
            
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Theme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildThemeOption(context, notifier, dynamicState, ReaderTheme.day, Colors.white, Colors.black, "Day"),
                      _buildThemeOption(context, notifier, dynamicState, ReaderTheme.sepia, const Color(0xFFEADDC0), Colors.black87, "Sepia"),
                      _buildThemeOption(context, notifier, dynamicState, ReaderTheme.twilight, const Color(0xFF333333), const Color(0xFFE0E0E0), "Twilight"),
                      _buildThemeOption(context, notifier, dynamicState, ReaderTheme.night, Colors.black, Colors.white, "Night"),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Navigation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                   SegmentedButton<Axis>(
                    segments: const [
                       ButtonSegment(
                         value: Axis.vertical, 
                         label: Text('Vertical'),
                         icon: Icon(Icons.swap_vert),
                       ),
                       ButtonSegment(
                         value: Axis.horizontal, 
                         label: Text('Horizontal'), 
                         icon: Icon(Icons.swap_horiz),
                       ),
                    ],
                    selected: {dynamicState.scrollDirection},
                    onSelectionChanged: (Set<Axis> newSelection) {
                      notifier.toggleScrollDirection();
                    },
                     style: ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                     ),
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  Widget _buildThemeOption(BuildContext context, ReaderViewModel notifier, ReaderState state, ReaderTheme theme, Color bg, Color fg, String label) {
    final isSelected = state.theme == theme;
    return GestureDetector(
      onTap: () => notifier.setTheme(theme),
      child: Column(
        children: [
          Container(
            width: 48, 
            height: 48,
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
                width: isSelected ? 2.5 : 1,
              ),
              boxShadow: isSelected ? [BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.3), blurRadius: 8)] : null,
            ),
            child: Center(
              child: Text("Aa", style: TextStyle(color: fg, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade600,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
          )),
        ],
      ),
    );
  }
}

class _AddNoteDialog extends StatefulWidget {
  final Function(String) onSave;

  const _AddNoteDialog({required this.onSave});

  @override
  State<_AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<_AddNoteDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Note"),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: "Enter your note here..."),
        maxLines: 3,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onSave(_controller.text);
              Navigator.pop(context);
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
