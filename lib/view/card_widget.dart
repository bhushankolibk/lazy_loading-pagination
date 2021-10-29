import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pagination/model/model_pagintion.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatefulWidget {
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PaginationData>(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepOrangeAccent,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: data.avatar,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.firstName + " ${data.lastName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(data.email),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.42,
            child: CachedNetworkImage(
              imageUrl: data.avatar,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
