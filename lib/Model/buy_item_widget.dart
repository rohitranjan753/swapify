import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'buy_item_model.dart';
import 'search_item_model.dart';

class BuyItemWidget extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  final BuyItemModel item;

  BuyItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(item.imageUrl),
            ),
          ),
          Text(item.title),
          // Text(item.creatorName),
          user!.uid == item.createdby
              ? Text(
                  'Uploaded By: YOU',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              : Text("Uploaded By: ${item.creatorName}"),

          Text(
            "\$${item.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
