import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectedBuyPage extends StatefulWidget {
  final DocumentSnapshot item;

  SelectedBuyPage({required this.item});

  @override
  State<SelectedBuyPage> createState() => _SelectedBuyPageState();
}

class _SelectedBuyPageState extends State<SelectedBuyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['creatorname']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.item['selldescription']),
            SizedBox(height: 20),
            Text(widget.item['sellprice']),
            SizedBox(height: 20),
            Text(widget.item['selltitle']),
          ],
        ),
      ),
    );
  }
}
