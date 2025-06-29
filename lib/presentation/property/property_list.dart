import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtbox/config/resources/assests_manager.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/utils/dialog_utils.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/usecase/category-list.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';
import 'package:realtbox/presentation/enquiry/bloc/enquiry_bloc.dart';
import 'package:realtbox/presentation/enquiry/enquiry_form_bottomsheet.dart';
import 'package:realtbox/presentation/propert_type/category_types_horizontal.dart';
import 'package:realtbox/presentation/propert_type/cubit/property_type_cubit.dart';
import 'package:realtbox/presentation/property-filter/property-filter-entity.dart';
import 'package:realtbox/presentation/property/bloc/propert_list_bloc.dart';
import 'package:realtbox/presentation/widgets/list_shimmer.dart';
import 'package:realtbox/presentation/widgets/new_property_item.dart';

class PropertyList extends StatelessWidget {
 
  bool isRefreshing = false;
  bool showEnquiry = false;

  PropertyList({super.key});

  PropertyFilter propertyFilter = PropertyFilter(
    selectedAmenities: [],
    selectedBudget: Budget(rangeValues: const RangeValues(0, 0)),
    selectedLocation: null,
    sortBy: SortBy(selectedId: ""),
  );

  Future<void> handleRefresh(BuildContext context) async {
    if (isRefreshing) return;
    isRefreshing = true;
    context.read<PropertListBloc>().add(RefreshData());
  }

  @override
  Widget build(BuildContext context) {
    String enroll = LocalStorage.getString(StringConstants.enrollmentType);
    String token = LocalStorage.getString(StringConstants.token);
    showEnquiry = enroll != StringConstants.enrollmentTypeAdmin;
    final bloc = BlocProvider.of<PropertListBloc>(context);
    // bloc.add(OnPropertyListInit(category: ""));
    return buildData(context, token);
  }

  Widget buildData(BuildContext context, String token) {
    ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<PropertListBloc>().add(LoadMoreData());
      }
    });

    return BlocListener<PropertListBloc, PropertListState>(
      listener: (context, state) async {
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
        if (state is NavigatetoRoute) {
          final result = await Navigator.pushNamed(context, state.route,
              arguments: state.propertyFilter);
          if (!context.mounted) return;
          propertyFilter = result as PropertyFilter;
          context.read<PropertListBloc>().add(
                OnPropertyFiletr(propertyFilter: propertyFilter),
              );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 65,
                        child: BlocProvider(
                          create: (context) =>
                              PropertyTypeCubit(getIt<GetCategoryList>()),
                          child: HorizontalCategoryTypes(
                            onCategoryChanged: (String category) {
                              context
                                  .read<PropertListBloc>()
                                  .add(OnPropertyListInit(category: category));
                            },
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context
                            .read<PropertListBloc>()
                            .add(OnPropertyFilterClicked());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: kPrimaryColor),
                            child: Center(
                                child: SvgPicture.asset(
                              filterSvg,
                              fit: BoxFit.contain,
                              width: 20,
                              height: 20,
                            ))),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<PropertListBloc, PropertListState>(
                  builder: (context, state) {
                    if (state is PropertListInitial ||
                        state is PropertListLoading &&
                            (state is! PropertListLoaded)) {
                      return listShimmer();
                      /* const Expanded(
                        child: Center(
                            child: CircularProgressIndicator.adaptive(
                          backgroundColor: kPrimaryColor,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kSecondaryColor),
                        )),
                      ); */
                    } else if (state is PropertListLoaded) {
                      var list = state.data;
                      isRefreshing = false;
                      if (state.data.isEmpty) {
                        return const Expanded(
                            child: Center(child: Text("No data available")));
                      } else {
                        return Expanded(
                          child: RefreshIndicator.adaptive(
                            onRefresh: () => handleRefresh(context),
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: false,
                              itemCount: state.hasReachedMax
                                  ? list.length
                                  : list.length + 1,
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                if (index >= list.length) {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(
                                      backgroundColor: kPrimaryColor,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          kSecondaryColor),
                                    ),
                                  );
                                }
                                return PropertyItemNew(
                                  property: list[index],
                                  index: index,
                                  showEnquiry: showEnquiry,
                                  onEnquiryClicked: () {
                                    if (token.isNotEmpty) {
                                      String propertyId =
                                          list[index].propertyId;
                                      debugPrint("PropertyId: $propertyId");
                                      showBottomSheet(context, propertyId);
                                    } else {
                                      showLoginDialog(context);
                                    }
                                  },
                                  onEnquiryListClicked: () {
                                    String propertyId = list[index].propertyId;
                                    String name = list[index].projectName;
                                    Navigator.pushNamed(
                                        context, RouteNames.enquiryList,
                                        arguments: {
                                          "propId": propertyId,
                                          "propName": name
                                        });
                                  },
                                  favouriteClicked: () {
                                    if (token.isNotEmpty) {
                                      String propertyId =
                                          list[index].propertyId;
                                      context.read<PropertListBloc>().add(
                                          OnFavouriteClicked(id: propertyId));
                                    } else {
                                      showLoginDialog(context);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      }
                    } else if (state is PropertListError) {
                      return Center(child: Text(state.message));
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showLoginDialog(BuildContext context) {
    showConfirmationDialog(context,
        title: "Login required",
        content: StringConstants.loginMessage,
        confirmButtonText: "Login Now",
        showSecondaryAction: true, onConfirmed: () {
      Navigator.pushNamed(context, RouteNames.authentication);
    }, onCancelled: () {});
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
