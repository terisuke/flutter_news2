import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget smartphoneLayout;
  final Widget tabletLayout;

  ResponsiveLayout(
      {required this.smartphoneLayout, required this.tabletLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return smartphoneLayout;
        } else {
          return tabletLayout;
        }
      },
    );
  }
}
