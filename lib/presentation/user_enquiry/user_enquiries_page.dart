import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/presentation/user_enquiry/bloc/user_enquiries_bloc.dart';
import 'package:realtbox/presentation/widgets/enquiry_item.dart';
import 'package:realtbox/presentation/widgets/user_enquiry_item.dart';

class UserEnquiryList extends StatelessWidget {
  
  const UserEnquiryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserEnquiriesBloc>(context)
        .add(OnEnquiryListInit());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Enquiries",
          style: TextStyle(
              color: kSecondaryColor, fontFamily: FontConstants.fontFamily),
        ),
        centerTitle: Platform.isAndroid ? false : true,
      ),
      body: SafeArea(
        child: BlocBuilder<UserEnquiriesBloc, UserEnquiriesState>(
          builder: (context, state) {
            if (state is UserEnquiriesInitial || state is EnquiryListLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: kPrimaryColor,
                  valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
                ),
              );
            } else if (state is EnquiryListLoaded) {
              var list = state.data;
              if (state.data.isEmpty) {
                return const Center(child: Text("No data available"));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: false,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final enquiry = list[index];
                      return UserEnquiryItem(
                        userName: enquiry.userName,
                        message: enquiry.message,
                        mobile: enquiry.userPhone,
                        imageUrl: enquiry.userImageUrl,
                        created: enquiry.created,
                        propertyName: enquiry.propertyName,
                      );
                    },
                  ),
                );
              }
            }

            return Container();
          },
        ),
      ),
    );
  }
}
