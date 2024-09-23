import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/usecase/get_property_list.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';
import 'package:realtbox/domain/usecase/toggle_favourite.dart';
import 'package:realtbox/presentation/property/bloc/propert_list_bloc.dart';
import 'package:realtbox/presentation/property/property_list.dart';
import 'package:realtbox/presentation/property/property_list_type.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = [
    const Tab(text: 'Saved'),
    const Tab(text: 'Recently Viewed'),
    // Tab(text: 'Tab3'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBar(
              bottom: TabBar(
                controller: _tabController,
                tabs: _tabs,
                labelColor: kSecondaryColor,
                indicatorColor: kPrimaryColor,
                unselectedLabelColor: grey,
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
            BlocProvider(
              create: (context) => PropertListBloc(
                getIt<GetPropertyList>(),
                getIt<SubmitEnquiry>(),
                getIt<ToggleFavourite>(),
                PropertyListType.saved,
              ),
              child: PropertyList(),
            ),
            BlocProvider(
              create: (context) => PropertListBloc(
                getIt<GetPropertyList>(),
                getIt<SubmitEnquiry>(),
                getIt<ToggleFavourite>(),
                PropertyListType.lastViewed,
              ),
              child: PropertyList(),
            ),
          ]),
        ),
      );
  }
}
