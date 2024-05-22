import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/presentation/dummy_list.dart/bloc/data_bloc.dart';
import 'package:realtbox/presentation/widgets/property_card.dart';

class DataScreenNew extends StatelessWidget {
  bool isRefreshing = false;

  Future<void> _handleRefresh(BuildContext context) async {
    if (isRefreshing) return;
    isRefreshing = true;
    context.read<DataBloc>().add(RefreshData());
  }

  DataScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DataBloc>(context).add(FetchData());

    ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<DataBloc>().add(LoadMoreData());
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC List with Pagination & Refresh'),
      ),
      body: BlocConsumer<DataBloc, DataState>(
        listener: (context, state) {
          /*  */
        },
        builder: (context, state) {
          if (state is DataInitial ||
              state is DataLoading && (state is! DataLoaded)) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataLoaded) {
            isRefreshing = false;
            return RefreshIndicator.adaptive(
              onRefresh: () => _handleRefresh(context),
              child: ListView.builder(
                controller: scrollController,
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return PropertyCard(text: state.data[index]);
                },
              ),
            );
          } else if (state is DataError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
