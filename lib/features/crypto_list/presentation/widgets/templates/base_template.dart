

import 'package:flutter/material.dart';

class BaseTemplate extends StatelessWidget {
  final String title; 
  final Widget body; 
  final Widget? floatingActionButton; 
  final bool showBackButton; 
  final List<Widget>? actions; 

  const BaseTemplate({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.showBackButton = false,
    this.actions
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: showBackButton ? IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)) : null,
      ),
    );
  }
}