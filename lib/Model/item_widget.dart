import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'item_model.dart';

class ItemWidget extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  final Item item;

  ItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(item.imageUrl),
            ),
            // child: CachedNetworkImage(
            //   imageUrl: item.imageUrl,
            //   placeholder: (context, url) => CircularProgressIndicator(),
            //   errorWidget: (context, url, error) => Icon(Icons.error),
            // ),
          ),
          Text(item.title),
          // Text(item.creatorName),
          user!.uid == item.createdby
              ? Text(
                  'Uploaded By: YOU',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              : Text("Uploaded By: ${item.creatorName}"),

          item.category.toString() == "sell"
              ? Text(
                  "\$${item.sellprice}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              : Text(
                  "\$${item.rentprice} / 12Hrs",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
        ],
      ),
    );
  }
}
