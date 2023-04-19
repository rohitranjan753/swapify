import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'item_model.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  ItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child:Image(image: NetworkImage(item.imageUrl),),
            // child: CachedNetworkImage(
            //   imageUrl: item.imageUrl,
            //   placeholder: (context, url) => CircularProgressIndicator(),
            //   errorWidget: (context, url, error) => Icon(Icons.error),
            // ),
          ),
          Text(item.title),
        ],
      ),
    );
  }
}
