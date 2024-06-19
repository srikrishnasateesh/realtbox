import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/core/utils/date_utils.dart';
import 'package:realtbox/presentation/widgets/avatar_widget.dart';

class EnquiryItem extends StatelessWidget {
  final String message;
  final String userName;
  final String mobile;
  final String imageUrl;
  final DateTime created;

  const EnquiryItem({
    Key? key,
    required this.message,
    required this.userName,
    required this.imageUrl,
    required this.mobile,
    required this.created,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                AvatarWidget(radius: 20, imageUrl: imageUrl, name: userName),
                const SizedBox(
                  width: 20,
                ),
                // ignore: prefer_const_constructors
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(userName.isEmpty ? "--" : userName),
                      Text(mobile.isEmpty ? "--" : mobile),
                    ],
                  ),
                ),
                Align(alignment: Alignment.centerRight, child: Text(formatDateTime(created)))
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(40, 8, 8, 8),
              child: Divider(
                height: 0.25,
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.message),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(child: Text(message)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
