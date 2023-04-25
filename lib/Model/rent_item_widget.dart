import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vbuddyproject/Model/rent_item_model.dart';

class RentItemWidget extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;
  final RentItemModel item;

  RentItemWidget({required this.item});

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
            "\$${item.price} / 12Hrs",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
