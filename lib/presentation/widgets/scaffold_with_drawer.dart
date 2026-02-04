import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_drawer.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  final Widget child;
  final GoRouterState state;

  const ScaffoldWithDrawer({
    super.key,
    required this.child,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: child,
    );
  }
}
