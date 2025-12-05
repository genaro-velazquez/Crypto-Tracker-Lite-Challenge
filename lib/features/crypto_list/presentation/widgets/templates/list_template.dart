

import 'package:flutter/material.dart';

class ListTemplate extends StatelessWidget {
  final String title; 
  final Widget listView; 
  final Future<void> Function()? onRefresh; 
  final List<Widget>? actions; 

  const ListTemplate({
    super.key,
    required this.title,
    required this.listView,
    this.onRefresh,
    this.actions
  });

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: onRefresh != null
          ? RefreshIndicator(
              onRefresh: onRefresh!,
              child: listView,
            )
          : listView,
    );
  }
}