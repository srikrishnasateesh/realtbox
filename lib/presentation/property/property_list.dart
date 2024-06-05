import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/presentation/property/bloc/propert_list_bloc.dart';
import 'package:realtbox/presentation/widgets/property_item.dart';

class PropertyList extends StatelessWidget {
  bool isRefreshing = false;

  PropertyList({super.key});

  Future<void> handleRefresh(BuildContext context) async {
    if (isRefreshing) return;
    isRefreshing = true;
    context.read<PropertListBloc>().add(RefreshData());
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PropertListBloc, PropertListState>(
          builder: (context, state) {
            if (state is PropertListInitial ||
                state is PropertListLoading && (state is! PropertListLoaded)) {
              return const Center(child: CircularProgressIndicator());
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
                        return const Center(child: CircularProgressIndicator());
                      }
                      return PropertyItem(
                        property: list[index],
                        index: index,
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
    );
  }
}
