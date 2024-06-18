import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/utils/dialog_utils.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';
import 'package:realtbox/presentation/enquiry/bloc/enquiry_bloc.dart';
import 'package:realtbox/presentation/enquiry/enquiry_form_bottomsheet.dart';
import 'package:realtbox/presentation/property/bloc/propert_list_bloc.dart';
import 'package:realtbox/presentation/widgets/property_item.dart';

class PropertyList extends StatelessWidget {
  bool isRefreshing = false;
  bool showEnquiry = false;

  PropertyList({super.key});

  Future<void> handleRefresh(BuildContext context) async {
    if (isRefreshing) return;
    isRefreshing = true;
    context.read<PropertListBloc>().add(RefreshData());
  }

  @override
  Widget build(BuildContext context) {
    String enroll = LocalStorage.getString(StringConstants.enrollmentType);
    debugPrint("Enrool: $enroll");
    showEnquiry = enroll != StringConstants.enrollmentTypeAdmin;
    final bloc = BlocProvider.of<PropertListBloc>(context);
    bloc.add(OnPropertyListInit());
    return buildData(context);
  }

  Widget buildData(BuildContext context) {
    ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<PropertListBloc>().add(LoadMoreData());
      }
    });

    return BlocListener<PropertListBloc, PropertListState>(
      listener: (context, state) {
        if (state.showConfirmation) {
          showConfirmationDialog(
            context,
            title: "Confirmation",
            content: "Your response received successfully",
            confirmButtonText: "Ok",
            onConfirmed: () {},
            onCancelled: () {},
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<PropertListBloc, PropertListState>(
            builder: (context, state) {
              if (state is PropertListInitial ||
                  state is PropertListLoading &&
                      (state is! PropertListLoaded)) {
                return const Center(
                    child: CircularProgressIndicator.adaptive(
                  backgroundColor: kPrimaryColor,
                ));
              } else if (state is PropertListLoaded) {
                var list = state.data;
                isRefreshing = false;
                if (state.data.isEmpty) {
                  return const Center(child: Text("No data available"));
                } else {
                  return RefreshIndicator.adaptive(
                    onRefresh: () => handleRefresh(context),
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: false,
                      itemCount:
                          state.hasReachedMax ? list.length : list.length + 1,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        if (index >= list.length) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: kPrimaryColor,
                            ),
                          );
                        }
                        return PropertyItem(
                          property: list[index],
                          index: index,
                          showEnquiry: showEnquiry,
                          onEnquiryClicked: () {
                            String propertyId = list[index].propertyId;
                            debugPrint("PropertyId: $propertyId");
                            showBottomSheet(context, propertyId);
                          },
                          onEnquiryListClicked: () {
                            String propertyId = list[index].propertyId;
                            String name = list[index].projectName;
                            Navigator.pushNamed(context, RouteNames.enquiryList,
                                arguments: {
                                  "propId": propertyId,
                                  "propName": name
                                });
                          },
                        );
                      },
                    ),
                  );
                }
              } else if (state is PropertListError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  void showBottomSheet(
    BuildContext context,
    String id,
    /*  VoidCallback Function({ String mobile, String message}) onResponse */
  ) async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => EnquiryBloc(getIt<SubmitEnquiry>()),
        child: BottomSheetWidget(
          propertyId: id,
        ),
      ),
    );
  }
}
