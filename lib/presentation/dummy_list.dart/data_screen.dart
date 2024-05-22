import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtbox/presentation/dummy_list.dart/bloc/data_bloc.dart';

class DataScreen extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isRefreshing = false;
    BlocProvider.of<DataBloc>(context).add(FetchData());
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC List with Pagination & Refresh'),
      ),
      body: BlocConsumer<DataBloc, DataState>(
        listener: (context, state) {
          if (state is DataLoaded) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
            isRefreshing = false;
          } else if (state is DataError) {
            _refreshController.loadFailed();
            _refreshController.refreshFailed();
          }
        },
        builder: (context, state) {
          if (state is DataInitial ||
              state is DataLoading && (state is! DataLoaded)) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataLoaded) {
            return InteractiveViewer(
              scaleEnabled: false,
              child: SmartRefresher(
                controller: _refreshController,
                enablePullUp: !state.hasReachedMax,
                onRefresh: () {
                  debugPrint("On Refresh");
                  if (isRefreshing) return;
                  isRefreshing = true;
              
                  context.read<DataBloc>().add(RefreshData());
                },
                onLoading: () {
                  debugPrint("On Loading");
                  context.read<DataBloc>().add(LoadMoreData());
                },
                child: ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.data[index]),
                    );
                  },
                ),
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
