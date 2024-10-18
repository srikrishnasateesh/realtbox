import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/core/utils/date_utils.dart';
import 'package:realtbox/presentation/widgets/avatar_widget.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class UserEnquiryItem extends StatelessWidget {
  final String message;
  final String propertyName;
  final String userName;
  final String mobile;
  final String imageUrl;
  final DateTime created;

  const UserEnquiryItem({
    super.key,
    required this.propertyName,
    required this.message,
    required this.userName,
    required this.imageUrl,
    required this.mobile,
    required this.created,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("created before format: $created");
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.business),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(child: BasicText(text:propertyName,
                textStyle: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize.s18
                ),)),
              ],
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
                Flexible(child: BasicText(text:message)),
              ],
            ),
            
            const Padding(
              padding: EdgeInsets.fromLTRB(40, 8, 8, 8),
              child: Divider(
                height: 0.25,
                color: kPrimaryColor,
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.person_2),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      BasicText(text:userName.isEmpty ? "--" : userName,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.normal
                      ),),
                      Text(mobile.isEmpty ? "--" : mobile),
                    ],
                  ),
                ),
                Align(alignment: Alignment.centerRight, child: Text(formatDateTime(created)))
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
