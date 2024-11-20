import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  final int id;
  final String content;
  const ListItem({super.key, required this.id, required this.content});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  void initState() {
    super.initState();
    debugPrint("${widget.id} initState");
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(widget.content),
    ));
  }
}
