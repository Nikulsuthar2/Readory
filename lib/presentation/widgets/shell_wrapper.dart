import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_drawer.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  final Widget child;

  const ScaffoldWithDrawer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: child,
      // We rely on the child pages to provide their own AppBars with leading Icon to open drawer,
      // OR we can provide a common AppBar here if appropriate (usually not for all paths).
      // However, ShellRoute usually wraps the body. 
      // If we want the drawer available, the Scaffold must be here.
      // But nested Scaffolds (in child) with AppBars will handle the leading menu icon automatically 
      // ONLY if there is a Drawer in the hierarchy up the tree? 
      // Actually, if the child Scaffold has an AppBar, it will look for a Drawer in its own Scaffold.
      // So effectively, EVERY page needs the Drawer *OR* we use this parent Scaffold.
      
      // Pattern:
      // Parent Scaffold (with Drawer)
      //  body: Child (Scaffold with AppBar)
      
      // Flutter's AppBar checks the *nearest* Scaffold for a Drawer. 
      // If the child has a Scaffold but no Drawer, the AppBar won't show the hamburger.
      
      // Solution: Pass the drawer to every page OR use a specific layout.
      // Easier: All main entries (Home, Library, Folders) share this Shell.
      // We can make them NOT return a Scaffold but just the body content, and let THIS Scaffold handle the AppBar?
      // No, usually screens define their AppBars.
      
      // Best approach for GoRouter Shell + Drawer:
      // This widget returns a Scaffold with the Drawer.
      // The `child` is the `navigationShell`.
      // Actually, standard material Drawer pattern implies the Scaffold *containing* the app bar has the drawer.
      
      // Alternative: The Shell returns a Row (Drawer + Body) for Desktop, or just Body for mobile 
      // where we assume pages use a reusable `ScaffoldWithCommonDrawer` wrapper?
      
      // Let's stick to the user's current pattern: They have `Scaffold` in `HomeScreen`, `LibraryScreen`.
      // We will inject the `AppDrawer` into the Shell's Scaffold, making it available?
      // No, `Scaffold.of(context)` looks up. 
      // If `HomeScreen` returns a `Scaffold`, it stops the look up.
      
      // So, we should *remove* `Scaffold` from `HomeScreen`, etc., or `AppDrawer` needs to be passed to each.
      // PREVIOUS CODE: `HomeScreen` had `drawer: const AppDrawer()`.
      
      // Refactor: We will use this `ScaffoldWithDrawer` as the ACTUAL Scaffold.
      // Child widgets should return the body content (and maybe an AppBar).
      // But AppBar needs to be in a Scaffold to work nicely?
      // Or we put the AppBar here in the Shell? But titles change.
      
      // OK, Plan B (Simpler):
      // Keep `Scaffold` in screens.
      // `ShellRoute` just keeps the state.
      // But wait, `ShellRoute` is usually for BottomNavBar.
      // For Drawer, `ShellRoute` is less critical UNLESS we want the drawer to stay open (Desktop).
      
      // If user complained "it in new page", it's because `context.push('/folders')` vs `context.go`.
      // And `/folders` didn't have the drawer attached.
      
      // The "Shell" concept is valid. Let's make `ScaffoldWithDrawer` wrapping the child.
      // We will modify Home/Library/Folders to *not* use their own Scaffold, OR we just put the Drawer here.
      // But changing all screens is invasive.
      
      // Let's TRY:
      // Shell Scaffold has Drawer.
      // Body is child.
      // Child is `HomeScreen` (which is a Scaffold).
      // Will `HomeScreen.AppBar` find the Shell's Drawer?
      // No, it finds `HomeScreen`'s Scaffold first (which has no drawer).
      
      // Modification required:
      // Screens should accept a `drawer` argument or we use a `MainLayout` widget.
      // I will create `MainLayout` that `HomeScreen`, `LibraryScreen`, `FolderManagementScreen` return.
    );
    throw UnimplementedError();
  }
}

/// A wrapper to provide the Drawer to all main routes consistently.
class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // This shell will wrap the main content.
    // However, since we want the Drawer to be defined ONCE, 
    // we effectively want the pages to be hosted inside a Scaffold that has the drawer.
    return Scaffold(
      drawer: const AppDrawer(),
      body: child, 
      // If child has its own Scaffold... the drawer won't be triggered by child's AppBar.
      // We might need to handle AppBar here or use a helper.
    );
  }
}
