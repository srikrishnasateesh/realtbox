import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/font_manager.dart';
import 'package:realtbox/presentation/enquiry_list/bloc/enquiry_list_bloc.dart';
import 'package:realtbox/presentation/widgets/enquiry_item.dart';

class EnquiryList extends StatelessWidget {
  final String propertyId;
  final String propertyName;
  const EnquiryList({
    super.key,
    required this.propertyId,
    required this.propertyName,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EnquiryListBloc>(context)
        .add(OnEnquiryListInit(properyId: propertyId));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          propertyName,
          style: const TextStyle(
              color: kSecondaryColor, fontFamily: FontConstants.fontFamily),
        ),
        centerTitle: Platform.isAndroid ? false : true,
      ),
      body: SafeArea(
        child: BlocBuilder<EnquiryListBloc, EnquiryListState>(
          builder: (context, state) {
            if (state is EnquiryListInitial || state is EnquiryListLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: kPrimaryColor,
                ),
              );
            } else if (state is EnquiryListLoaded) {
              var list = state.data;
              if (state.data.isEmpty) {
                return const Center(child: Text("No data available"));
              } else {
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: false,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final enquiry = list[index];
                    return EnquiryItem(
                      userName: enquiry.userName,
                      message: enquiry.message,
                      mobile: enquiry.userPhone,
                      imageUrl: enquiry.userImageUrl,
                    );
                  },
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
